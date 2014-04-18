#!/bin/bash
((ord=$1))
for ((i=1;i<=$ord;i++))
        do
        for ((k=i;k<=$ord;k++))
                do
                echo -ne " "
                done
        for ((j=1;j<=i;j++))
                do
                echo -ne "*"
                done
        for ((z=2;z<=i;z++))
                do
                echo -ne "*"
                done
        echo
        done
exit 0
