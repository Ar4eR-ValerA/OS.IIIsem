#!/bin/bash
title="MiB_Mem_free MiB_Mem_used MiB_Mem_cache MiB_Swap_free MiB_Swap_used MiB_Swap_avail "
counter=1
while [ $counter -lt 6 ]
do
    title+=""$counter"PID "$counter"VIRT "$counter"RES "$counter"SHR "$counter"%CPU "$counter"%MEM "$counter"TIME+ "$counter"COMMAND "
    let "counter = counter + 1"
done
echo -e $title > top_record.log

while [ true ]
do
    top -bn1 | head -n 4 | tail -n 1 | awk {'printf("%s %s %s ", $6, $8, $10)'} >> top_record.log
    top -bn1 | head -n 5 | tail -n 1 | awk {'printf("%s %s %s ", $5, $7, $9)'} >> top_record.log

    counter=0
    while [ $counter -lt 5 ]
    do
        let "number = 8 + counter"
        top -bn1 | head -n $number | tail -n 1 | awk {'printf("%s %s %s %s %s %s %s %s ", $1, $5, $6, $7, $9, $10, $11, $12)'} >> top_record.log
        let "counter = counter + 1"
    done
    echo "" >> top_record.log

done