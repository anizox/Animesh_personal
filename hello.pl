#!/usr/bin/perl
#This is my very perl program to print hello world
use strict;
use warnings;
print "Enter your Name\n";
my $naame = readline STDIN;
chomp ($naame);
print "$naame Says Hello World\n";
if ($naame eq "animesh")
{ print "HI Animesh, perl says hello too!!\n";
}
else
{ print "Hello to yo too!!\n";

}

