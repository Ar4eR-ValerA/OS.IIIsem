#!/bin/bash
trash="$HOME/.trash"
file="$PWD/$1"
log="$HOME/.trash.log"

if [ ! -d "$trash" ]
then
    mkdir "$trash"
    >$log
fi

if [ ! -f "$file" ]
then
    echo "File doesn't exist"
    exit "1"
fi

if [ "rmtrash.bash" = "$1" ]
then
    echo "You can't delete rmtrash.bash"
    exit "1"
fi

link_name="$1$RANDOM"
ln "$file" "$trash/$link_name" 2> temp
if [ -z $(cat temp) ]
then
    echo "$file/$link_name" >> $log
    rm "$file"
    rm temp
else
    echo "Can't create hard link"
    rm temp
    exit "1"
fi