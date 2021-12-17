#!/bin/bash
>temp1
>temp2

processes=$(ls /proc | grep -e [[:digit:]] | sort -n)
for pid in $processes
do
	echo $pid $(grep -s "rchar:" "/proc/$pid/io" | awk '{printf("%s", $2)}') >> temp1
done

sleep 10

for pid in $processes
do
	echo $pid $(grep -s "rchar:" "/proc/$pid/io" | awk '{printf("%s", $2)}') >> temp2
done

cat temp1 | while read str
do
	pid=$(echo $str | awk '{printf("%d", $1)}')

	rchar_before=$(echo $str | awk '{printf("%d", $2)}')
	rchar_after=$(cat temp2 | awk -v pid_awk=$pid '{if ($1 == pid_awk) printf("%d", $2)}')
    rchar_diff=$(($rchar_after-$rchar_before))
    
    cmd=$(ps -q $pid | sed '1d' | awk '{printf("%s", $4)}')
	echo $pid":"$cmd":"$rchar_diff
done | sort -t ":" -nrk3 | head -3

rm temp1
rm temp2