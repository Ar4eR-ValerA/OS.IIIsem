#!/bin/bash

counter=0
K=$1
N=$2
while [ $counter -lt $K ]
do
    ./newmem.bash $N &
    let "counter = counter + 1"
done