#!/usr/bin/perl

use strict;
use warnings;


#===============================================================#
#       User input for logs and timing                          #
#===============================================================#

print "*** Script Requirement ***\n\n";
print "This script extract Adjustment of Capital which is done from GLSIM and create Capital.slr\n\n";
print "For that we need below files\n\t1. GLSIM log : sim-core.YYYY-MM-DD.log\n\t2. Exported Capital file : Capital.slr\n\n";
print "Also time stamp between which we need to extract Adjustment Capital\n\t1. Start Time : HH:MM \n\t2. End time : HH:MM\n\n";

print "Please enter GLSIM File name : ";
my $glsim_log = <STDIN>;
chomp ($glsim_log);

print "Please enter exported Capital file : ";
my $capital_exp = <STDIN>;
chomp ($capital_exp);

print "Please enter Start time (HH:MM) : ";
my $start_time = <STDIN>;
chomp ($start_time);

print "Please enter End time (HH:MM) : ";
my $end_time = <STDIN>;
chomp ($end_time);



# Variable for file generation

my $capital_file = 'Capital.slr.tmp';
my $extract_file = 'Extract_amount.txt';


#===============================================================#
#       Check presence of old file                              #
#       if present then rename it old                           #
#===============================================================#

if (-e $capital_file || $extract_file)
{

        rename "$capital_file","$capital_file.old";
        rename "$extract_file","$extract_file.old";

}



#===============================================================#
#       Extracting Capital Adjustment from GLSIM                #
#===============================================================#

open (GLSIMFH, "$glsim_log");
open (EXTRFH, ">> $extract_file"); 

        while (<GLSIMFH>)
        {
                chomp;
                my $line = $_;

                if ($line =~ /$start_time:\d\d,\d\d\d/ .. /$end_time:\d\d,\d\d\d/)
                {
                        if ($line =~ /selector_longCapitalAdjustment/)
                        {
                                if ($line =~ /not a valid FIX message/)
                                {
                                my ($time,$account,$amount) = ($line =~ m|(\d\d:\d\d:\d\d,\d\d\d).*<portId>(.*)</portId>.*<amount>(.*)</amount>|);
                                my ($scbprdsg,$folder,$SXA,$SSA) = split (/\\/,$account);

                                ## Reading Capital.slr file to extarct currency.

                                        open (CAPFH, "$capital_exp");

                                                while (<CAPFH>)
                                                {
                                                        chomp;
                                                        my $read_capital = $_;
                                                        if ($read_capital =~ /$SSA/)
                                                        {
                                                                my @temp_arr = split (/\t/,$read_capital);
                                                                my $currency = $temp_arr[12];

                                                                if ($amount =~ m/-\d*/)
                                                                { print EXTRFH "$time\t$account\t$SSA\t$amount\t$currency\tWithdrawal\n"; }
                                                                else
                                                                { print EXTRFH "$time\t$account\t$SSA\t$amount\t$currency\tDeposit\n"; }
                                                        }
                                                }
                                }
                        }
                }
        }

close (EXTRFH);


#===============================================================#
#       Mapping Extract Capital in Capital.slr format           #
#===============================================================#



# lno is variable which is used to assign line in Capital.slr

my $lno = 9;

sleep (5);

# Create upper line of Capital.slr and append it.

open (NCAPFH,">> $capital_file");

print NCAPFH "CAPITAL\n";
print NCAPFH "V1.04\n";
print NCAPFH "scb\n";
print NCAPFH "\n";
print NCAPFH "LINE\tPATH\tUSERID\tCLIENT\tDAILY CAPITAL\tLONG CAPITAL\tSHORT CAPITAL\tCAPITAL/ORDER\tQUANTITY/ORDER\tNB ORDERS/SEC\tCREDIT\tRATIO\tCURRENCY\tNB MESSAGES\tP&L\tUNREALISED P&L\tREALISED P&L\tAUTOLOCKOUT\tP&LMODE\tCALCULATION MODE\tCAPITAL ADJUSTMENT\tLONG CAPITAL ADJUSTMENT\tSHORT CAPITAL ADJUSTMENT\tCREDIT ADJUSTMENT\tMANIP CAP\tMANIP PRCT\tSTART TIME\tEND TIME\tFILTER TYPE\tPNL ADJUSTMENT\tFILTER NAME\tCAPITAL RATIO\tIS REJECT RECYCLED\tCAPITAL ADJUSTMENT VALIDITY DATE\tLONG CAPITAL ADJUSTMENT VALIDITY DATE\tSHORT CAPITAL ADJUSTMENT VALIDITY DATE\tCREDIT ADJUSTMENT VALIDITY DATE\tPNL ADJUSTMENT VALIDITY DATE\tADD FEES TO CAPITAL\tBI DIRECTIONAL PRCT CLOSING\n";
print NCAPFH "6\tscbprdsg\\\t\t\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>/<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t4\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\tGlobal\t100.30\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\n";
print NCAPFH "7\tscbprdsg\\migrated\\\t\t\t<NO>\t*\t<NO>\t<NO>\t<NO>\t<NO>/<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t4\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\tGlobal\t100.30\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\n";
print NCAPFH "8\tscbprdsg\\non-migrated\\\t\t\t<NO>\t*\t<NO>\t<NO>\t<NO>\t<NO>/<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t4\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\tGlobal\t100.30\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\n";

# Opening file which having extract and mapping in Capital.slr format

open (EXTFH, "$extract_file");

while (<EXTFH>)
{
        chomp;
        my $file_extract = $_;
        (my $time, my $path, my $account, my $amount, my $currency, my $status) = split (/\s+/,$file_extract);
        #print "$path\n";
        my @temp_arr = split (/\\/, $path);
        my $acc_path = "$temp_arr[0]\\$temp_arr[1]\\$temp_arr[2]\\";
        &SXA_account($acc_path,$lno++);
        &SSA_account($path,$account,$amount,$lno++,$currency);
}

sub SXA_account {

my $SXA = shift(@_);
my $ln = shift(@_);
print NCAPFH "$ln\t$SXA\t\t\t<NO>\t*\t<NO>\t<NO>\t<NO>\t<NO>/<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t4\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\tGlobal\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\n";

}

sub SSA_account {
my $acc_path = shift(@_);
my $SSA = shift(@_);
my $amt = shift (@_);
my $ln = shift (@_);
my $cur = shift (@_);
print NCAPFH "$ln\t$acc_path\t\t$SSA\t<NO>\t*\t<NO>\t<NO>\t<NO>\t<NO>/<NO>\t<NO>\t<NO>\t$cur\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t4\t<NO>\t$amt\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\tGlobal\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t<NO>\t1\t<NO>\n";
}


close (NCAPFH);
close (GLSIMFH);
close (EXTFH);
