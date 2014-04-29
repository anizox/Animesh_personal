#!/bin/bash
lineno=0
while IFS='|' read -ra fields;
do
((lineno++))
for idx in ${!fields[@]};
	do
	if [[ ${fields[idx]%% }  == "" ]]; then
            	flag=1
		COLNUM=("${COLNUM[@]}" "$idx")
        fi
	done
	if [ "$flag" ==  "1" ];then
	echo "line number $lineno has at least one empty field"
	echo -en "Empty coloumns are: "
	for i in "${COLNUM[@]}"
	do
	printf "$i "
	done
	unset COLNUM
	fi
echo
done < secmaster.txt

