#!/bin/bash
start_time1=$(date '+%d.%m.%y_%H:%M:%S')
mkdir ~/test && {
    echo "catalog test was created successfully" >> ~/report
    > ~/test/$start_time1
}

start_time2=$(date '+%d.%m.%y_%H:%M:%S')
ping www.net_nikogo.ru || echo "$start_time2 error" >> ~/report