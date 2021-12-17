#!/bin/bash
result=1
operator="+"
(tail -f pipe) | while true;
do
    read line;
    case $line in
    "+")
        operator="+"
    ;;
    "*")
        operator="*"
    ;;
    [0-9]*)
        let result=$result$operator$line
        echo "result is $result"
    ;;
	"QUIT")
		echo "exit"
        killall tail
		exit 0
    ;;
	*)
		echo "incorrect argument error"
        killall tail
		exit 1
    ;;
	esac
done