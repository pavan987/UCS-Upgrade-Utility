#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  getList.pl
#
#        USAGE:  ./getList.pl  
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
#      CREATED:  06/14/2014 02:53:29 PM
#     REVISION:  ---
#===============================================================================

use strict;
#use warnings;

if((!defined $ARGV[0]) ) {
print "Usage: ./getBuildStatus.pl Branch buildnum buildtype platform\n";
exit;
}
my @builds;
my $branch=$ARGV[0];
my $buildnum=$ARGV[1];
my $buildtype=$ARGV[2];
my $image=$ARGV[3];
my $platform=$ARGV[4];
my $value;
my $status;
my $dirname = "/auto/savbu-releng/buildsa/builds/ucs-b-series/$branch/$buildnum/../Images.$buildnum";
if($image eq "infra")
{
if ($platform eq "3gfi") {
$value ="ucs-6300-k9-bundle-infra";
}
elsif ($platform eq "mini") {
$value="ucs-mini-k9-bundle-infra";
}
elsif ($platform eq "Mammoth") {
$value="ucs-mini-k9-bundle-infra";
}
}
elsif($image eq "b")
{
$value="ucs-k9-bundle-b-series";
}
elsif($image eq "c")
{
$value="ucs-k9-bundle-c-series";
}
elsif($image eq "m")
{
$value="ucs-k9-bundle-m-series";
}


if( -e "$dirname/gdb_".$value."_failed")
{
$status = "Failed";
}
else {
$status = "OK";
}


print $status;
#opendir my($dh), $dirname or die "Couldn't open dir '$dirname': $!";
#my @files = readdir $dh;
#closedir $dh;
#@files = sort { $b <=> $a } @files;
#foreach (@files) {
#if(($_ eq $_+0 ) || ($_ =~ /^FCS/)) {
#print "$_\n";
#}
#}
