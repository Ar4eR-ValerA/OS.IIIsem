#!/bin/bash
mkfifo pipe
./script5.bash&
while true
do
	read line
	echo "$line" > pipe

	if [[ $line == "QUIT" ]]
	then
		rm pipe
		exit 0
    fi

	if [[ ! $line =~ [0-9"+*"]+ ]]
	then
		rm pipe
		exit 1
    fi
done	