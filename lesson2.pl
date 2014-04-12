#!/usr/bin/perl
use strict;
use warnings;

my $num1;
my $num2;
my $num3;
my $ans;
my $choice;

&menu;
sub menu {
print "Welcome to perl calculator\n",
"\n",
"1. ADD\n",
"2. SUBTRACT\n",
"3. MULTIPLY\n",
"4. DIVIDE\n",
"5. EXIT\n",
"\n",
"SO what's your choice?\n";

$choice = readline STDIN;
chomp ($choice);

if ( $choice==1) {
&add;
}

elsif ($choice==2)
        {&subt; }

elsif ($choice==3)
        {&mult; }
elsif ($choice==4)
        {&div;  }
elsif ($choice==5)
        {print "Thank you, Do visit again\n";
        exit; }
}

sub add {
        print "Enter 1st Number\n";
        $num1 = readline STDIN;
        chomp ($num1);
        print "Enter 2nd Number\n";
        $num2 = readline STDIN;
        chomp ($num2);
        $ans = $num1 + $num2;
        print "Answer: $num1 + $num2 = $ans\n";
        &menu;
        }

sub subt {
        print "Enter 1st Number\n";
        $num1 = readline STDIN;
        chomp ($num1);
        print "Enter 2nd Number\n";
        $num2 = readline STDIN;
        chomp ($num2);
        $ans = $num1 - $num2;
        print "Answer: $num1 - $num2 = $ans\n";
        &menu;
        }

sub mult {
        print "Enter 1st Number\n";
        $num1 = readline STDIN;
        chomp ($num1);
        print "Enter 2nd Number\n";
        $num2 = readline STDIN;
        chomp ($num2);
        $ans = $num1 * $num2;
        print "Answer: $num1 X $num2 = $ans\n";
        &menu;
        }

sub div {
        print "Enter 1st Number\n";
        $num1 = readline STDIN;
        chomp ($num1);
        print "Enter 2nd Number\n";
        $num2 = readline STDIN;
        chomp ($num2);
        $ans = $num1 / $num2;
        print "Answer: $num1 / $num2 = $ans\n";
        &menu;
        }
