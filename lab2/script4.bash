#!/bin/bash
> file4.txt
for pid in $(ps -eo pid | sed '1d')
do
    exec_runtime=$(grep -sh "sum_exec_runtime" "/proc/$pid/sched" | awk '{printf("%f", $3)}')
    nr_switches=$(grep -sh "nr_switches" "/proc/$pid/sched" | awk '{printf("%f", $3)}')
    ppid=$(grep -sh "^PPid:" "/proc/$pid/status" | awk '{printf("%d", $2)}')

    if [ $nr_switches ]
	then
        art=$(echo "scale=3; $exec_runtime/$nr_switches" | bc)
	else
		art=$(echo "-1")
	fi

    if [ "$ppid" != "" ]
	then
        echo "ProccesID= $pid : Parent_ProcessID= $ppid : Average_Running_Time= $art" >> file4.txt
    fi
done
cat file4.txt | sort -nk5 > file4.txt