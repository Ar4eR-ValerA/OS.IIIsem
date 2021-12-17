#!/bin/bash
./proc4.bash &
pid1=$!
cpulimit -p $pid1 -zl 10 &

./proc4.bash &
pid2=$!
./proc4.bash &
pid3=$!

read -sn 1
kill $pid3

read -sn 1
kill $pid2
kill $pid1