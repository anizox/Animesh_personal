#SCRIPT TO PRINT "5,4,3,2,1" exactly using while loop
#!/usr/bin/perl
#!/bin/bash

no=$1
while test $no -ge 1
do
echo -en "$no"
if [ $no -gt 1 ]
then
echo -en ","
fi
((no=$no-1))
done

echo
