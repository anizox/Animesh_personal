#!/usr/bin/perl
use strict;
use warnings;

my @fruits;
my $fruit;
my $num=1;

while ($num le 5){

printf "\n HI Enter a fruit: ";
$fruit=readline STDIN;
chomp($fruit);
push (@fruits,$fruit);
$num++;
}
print "\nHi Your fav Fruits are : @fruits\n";

