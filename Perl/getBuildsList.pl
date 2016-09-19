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
if(!$#ARGV eq 0)
{
exit;
}
my @builds;
my $branch=$ARGV[0];
my $dirname = "/auto/savbu-releng/buildsa/builds/ucs-b-series/$branch";

opendir my($dh), $dirname or die "Couldn't open dir '$dirname': $!";
my @files = readdir $dh;
closedir $dh;
@files = sort { $b <=> $a } @files;
foreach (@files) {
if(($_ eq $_+0 ) || ($_ =~ /^FCS/)) {
print "$_\n";
}
}
