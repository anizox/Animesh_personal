#!/usr/bin/perl
# This scripts helps user guess a system generated random number between 1 to 50
# This is enhancement of lesson 4 ; it is using new loop called as foreach (for and array)
use strict;
use warnings;

my $num; #original number to be guessed
my $guessnum=0; #number guessed by user
my $totguess=0; #total number of guesses by user
my @GUESS;	#all the guesses by user stored in an array

$num=rand (50);	#rand function to generate a random number between 1-50
$num=int($num+1);	# to get integer value only

while ($num ne $guessnum)
{
	print "\n Guess a number between 1-50 :: ";
	$guessnum= readline STDIN;
	chomp ($guessnum);
		
		if ($guessnum < $num)
			{printf "\nNOPE, you need higher\n";}
		if ($guessnum > $num)
			{printf "NOPE, you need lower\n";}
	$totguess++;
	push (@GUESS,$guessnum);	#To push the guessed number in the array

}
my $tottries=$#GUESS + 1; # "$#arrayname gives last slot of the array, remember array starts from 0, hence we use +1 for total number"
print "\n Magic Number was $num\t",
"\n Your total Number of Attempts were :: $tottries",
"\n Your gusses were :: ";

foreach my $slot (@GUESS){	# foreach is a loop to traverse throuh an array.
print "$slot ";
}



