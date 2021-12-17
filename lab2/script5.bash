#!/bin/bash
> file5.txt
current_ppid=-1
art_sum=1
art_count=1

cat file4.txt > temp
echo "end -1" >> temp

cat temp | while read str
do
    pid=$(echo $str | awk '{printf("%d", $2)}')
    ppid=$(echo $str | awk '{printf("%d", $5)}')
    art=$(echo $str | awk '{printf("%f", $8)}')

    if [ $current_ppid == $ppid ]
    then
        art_sum=$(echo $art_sum+$art | bc)
        art_count=$(($art_count+1))
    else
        if [ "$art_count" != "0" ]
        then
            avg=$(echo "scale=6; $art_sum/$art_count" | bc)
            echo "Average_Running_Children_of_ParentID= $current_ppid is $avg" >> file5.txt
        fi
        current_ppid=$ppid
        art_count=1
        art_sum=$art
    fi
    
    if [ "$pid" != "-1" ]
    then
        echo "ProccesID= $pid : Parent_ProcessID= $ppid : Average_Running_Time= $art" >> file5.txt
    fi
done

rm temp