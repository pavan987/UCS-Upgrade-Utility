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
my ($out,$out1);

if( !(defined $ARGV[0]) || ($#ARGV != 2) )
{
print "Usage: ./script.pl Branch build type\n";
exit;
} 
my $branch = $ARGV[0];
my $build = $ARGV[1];
my $type = $ARGV[2];
my $type1;
my $branch1;

# Deciding the Type
if ($branch eq "fletcher_cove-builds") {
if($type eq "sanity")
{
$type1 = "mucs-sanity_Results";
}
else
{
$type1 = "mucs-nightly_Results";
}
}

else {
if($type eq "sanity")
{
$type1 = "sanity_Results";
}
else
{
$type1 = "nightly_Results";
}
}

# Deciding the Branch
if ($branch eq "elcapitan_mr2-builds")
{ $branch1 = "elcap-mr2"; }
elsif ($branch eq "oakland_phase1-builds")
{ $branch1 = "fletcher-mr1"; }
elsif($branch eq "fletcher_cove-builds")
{ $branch1 = "fletcher"; }
else {
print "Sanity for project is not started";
exit;
}


my $dir = "/auto/ucs-automation/Regression/Results/$type1/automation/$branch1/$build/";
if( ! -d $dir )
{
print "Sanity not Avaialble";
exit;
}

$out= ` find $dir -name ResultsSummary.xml  `;
print $out;
$out1=`cat $out`;
my ($passed) = $out1 =~ /.*<passed>(.*)<\/passed>/i; 
my ($failed) = $out1 =~ /.*<failed>(.*)<\/failed>/i;
if($failed > 0)
{
print "FAIL"
} 
else
{
print "PASS"

}
print " (Passed: $passed  Failed: $failed) ";

