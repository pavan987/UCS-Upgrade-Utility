#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  getSanity.pl
#
#        USAGE:  ./getSanity.pl  
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
#      CREATED:  06/27/2014 04:32:46 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
my ($out,$out1,$out2);

if( !(defined $ARGV[0]) )
{
print "Usage: ./script.pl Branch build type platform\n";
exit;
} 
my $branch = $ARGV[0];
my $build = $ARGV[1];
my $type = $ARGV[2];
my $platform = $ARGV[3];
my $type1;
my $branch1;

# Deciding the Type
if ($platform eq "mini") {
if($type eq "sanity")
{
$type1 = "mucs-sanity_Results";
}
else
{
$type1 = "mucs-nightly_Results";
}
}

elsif ($platform eq "3gfi") {
if($type eq "sanity")
{
$type1 = "3gfi-sanity_Results";
}
else
{
$type1 = "3gfi-nightly_Results";
}
}
else {
if($type eq "sanity")
{
$type1 = "ucs-sanity_Results";
}
else
{
$type1 = "ucs-nightly_Results";
}


}

# Deciding the Branch
if ($branch eq "elcapitan_ms_mr1-builds")
{ $branch1 = "elcap-ms-mr1"; }
elsif($branch eq "granada-builds")
{ $branch1 = "granada"; }
else {
print "$type for project is not started";
exit;
}
my $dir = "/auto/ucs-automation/Regression/Results/$type1/automation/$branch1/$build/";
if( ! -d $dir )
{
print "$type Not Avaialble";
exit;
}
$out= ` find $dir -name ResultsSummary.xml  `;
if($out eq "")
{
print "$type is either running or not run";
exit;
}
$out1=`cat $out`;
my ($passed) = $out1 =~ /.*<passed>(.*)<\/passed>/i; 
my ($failed) = $out1 =~ /.*<failed>(.*)<\/failed>/i;
my ($errored) = $out1 =~ /.*<errored>(.*)<\/errored>/i;
my ($aborted) = $out1 =~ /.*<aborted>(.*)<\/aborted>/i;
my ($blocked) = $out1 =~ /.*<blocked>(.*)<\/blocked>/i;

my $fail = $failed + $errored + $aborted + $blocked;
if($fail > 0)
{
print "FAIL"
} 
else
{
print "PASS"

}
print " (Passed: $passed  Failed: $fail) ";

