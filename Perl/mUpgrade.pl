#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  upgrade.pl
#
#        USAGE:  ./upgrade.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Pavan Kumar Gondhi (UCSM QA), pgondhi@cisco.com
#      COMPANY:  Cisco Systems
#      VERSION:  1.0
#      CREATED:  04/28/2014 11:00:18 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use Expect;
use lib '/var/www/html/perl';
use mydb;
use commonlib;
my ($loghead,$logmesg,$err);

#Read Inputs
if((!defined $ARGV[0]) or ($#ARGV != 3)) {
print "Usage: ./upgrade.pl Username Branch buildnum buildtype\n";
exit;
}
my $DB_user = $ARGV[0];
my $branch = $ARGV[1];
my $buildnum = $ARGV[2];
my $buildtype = $ARGV[3];
my $ver;
if($branch eq "granada-builds") {
$ver = "3.1.0";
}

my $buildname = "ucs-k9-bundle-m-series.$ver.$buildnum.M.$buildtype";

# Builds Directory
my $path = "/auto/savbu-releng/buildsa/builds/ucs-b-series/$branch/$buildnum/../Images.$buildnum/$buildname";


if(! -e $path)
{
print "File not present\n";
$loghead="Upgrade Failed:";
$logmesg="Bundle $buildname Not available in Build server";
$err=1; goto RETURN;
}

# Create a Dymanic Directory
#my $i=0;
#while (-d "$username".$i++ )
#{ }
#$i--;
#system("mkdir $username".$i);
#my $dir=$username.$i;
#chdir $dir;

# Copy build to Directory if not exists
if (-e "/var/www/html/perl/builds/$branch/$buildname")
{
print "File Exists\n";
mydb::insertLog($DB_user, "M-Upgrade", "Download Complete:","  Bundle $buildname already Present in Local server");
}
else {

print "Downloading $buildname to local server from build server\n";
mydb::insertLog($DB_user, "M-Upgrade", "Download Started:","  Downloading $buildname to local server from build server");
system("cp $path /var/www/html/perl/builds/$branch/");
mydb::insertLog($DB_user, "M-Upgrade", "Download Completed","  $buildname Downloaded to local server");

}

# get Details from Database
my ($cmd,$exp);
my $prompt = "Password";
my($IP,$Username,$Password) = mydb::getConfigUCSM($DB_user);
if((!defined $IP) || (!defined $Username) || (!defined $Password) ){
print "No testbed Registered to UCS Health Monitor, Register your testbed\n";
$loghead="Upgrade Failed:";
$logmesg="No testbed Registered to UCS Health Monitor, Register your testbed";
$err=1; goto RETURN;
}
my $buildip="10.197.123.48";
my $timeout=10;

# Login through SSH
$cmd = "ssh -l $Username $IP";
$exp = new Expect();
$exp->raw_pty(0);
$exp->spawn($cmd);
if(!$exp->expect (10, [qr/\(yes\/no\)\?\s*$/ => sub { $exp->send("yes\n"); exp_continue; } ],
 [$prompt => sub{ $exp->send("$Password\n"); } ] )) {
print "Login to UCSM Failed, Check the testbed IP registered is reachable \n";
$loghead="Upgrade Failed:";
$logmesg="Login to UCSM Failed, Check the testbed IP registered is reachable";
$err=1; goto RETURN;
}


# Download the bundle to UCSM If not present

if(!$exp->expect($timeout,"#")) {
print "Login to UCSM Failed, Check your testbed Credentials are correct \n";
$loghead="Upgrade Failed:";
$logmesg="Login to UCSM Failed, Check your testbed Credentials are correct";
$err=1; goto RETURN;

}

$exp->send("scope firmware\r");
$exp->expect($timeout,"#");
$exp->send("show package | no-more \r");
if(!$exp->expect(10,"$buildname"))
{
$exp->send("download image scp://upgrade\@$buildip:/var/www/html/perl/builds/$branch/$buildname\r");
$exp->expect($timeout,"Password");
$exp->send( "nbv12345\r");
$exp->expect($timeout,"#");
mydb::insertLog($DB_user, "M-Upgrade", "Downloading to UCSM:","  Downloading $buildname to UCSM");

# Wait for Completion of Downloadi
my $retry=25;
my $count=0;

while($count<$retry)
{
$exp->send("show download-task $buildname\r");
if( !$exp->expect(10,"Downloaded") )
{
if($exp->expect(5,"Failed"))
{
print "Downloading Image Failed to UCSM\n";
$loghead="Upgrade Failed:";
$logmesg="$buildname Download failed to UCSM";
$err=1; goto RETURN;
}

$count++;
sleep 30;
}

else
{last;}

}

if($count == $retry)
{
print "Downloading Image Failed to UCSM\n";
$loghead="Upgrade Failed:";
$logmesg="$buildname Download failed to UCSM";
$err=1; goto RETURN;
}

}



print "Image Downloaded to UCSM\n";
mydb::insertLog($DB_user, "M-Upgrade", "Download Completed:","  $buildname Downloaded to UCSM");
# Get the Package Version 
$exp->expect($timeout,"#");
$exp->send("show package $buildname\r");
$exp->expect($timeout,"#");
my $package = $exp->exp_before();
$package =~  s/^.*\r\n.*\n.*\n$buildname\s*(.*)\n.*/$1/;

#Triger Autoinstall
$exp->send("scope org\r");
$exp->expect($timeout,"#");
$exp->send("scope fw-host-pack default\r");
$exp->expect($timeout,"#");
$exp->send("set mseries-vers $package");
$exp->expect($timeout,"#");
$exp->send("commit-buffer\r");
$exp->expect($timeout,"#");

print "Auto Install Upgrade Process Started\n";
mydb::insertLog($DB_user, "M-Upgrade", "Upgrade Started:","  Upgrading Endpoints to build $buildnum using Host Fw pack");
$exp->send("exit\r");
$exp->close();

RETURN:
if($err)
{
 print("Script FAIL\n");
 mydb::insertLog($DB_user, "M-Upgrade", $loghead,$logmesg);
}

