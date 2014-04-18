#!/usr/bin/perl
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
printf "\n Magic Number was $num";
printf "\n You've got it right in $totguess attempts :: and \n Your Attempts were @GUESS\n";



