#!/bin/bash
trash="$HOME/.trash"
trash_log="$HOME/.trash.log"
restoring_file="$PWD/$1"

if [ ! -d "$trash" ]
then
    echo "There is no trash"
    exit 1
fi

if [ ! -e "$trash_log" ]
then
    echo "There is no trash's logs"
    exit 1
fi

while read -u 3 current_file
do
    current_file_name="$(basename "$current_file")"
    echo $current_file_name
    echo $1
    
    trash_file="$trash/$current_file_name"
    if [ -e "$trash_file" ] && [[ "$current_file_name" =~ "$1" ]]
    then
        echo $trash_file
        echo "Restore this file?"
        read answer
        if [ $answer = "y" ]
        then
            if [ -d "$(dirname $restoring_file | head -n 1)" ]
            then
                if [ ! -e "$restoring_file" ]
                then
                    ln "$trash_file" "$restoring_file" 2> temp
                else
                    echo "This file already exist. Rename file"
                    read new_file_name
                    while [ -e "$new_file_name" ]
                    do
                        echo "This file already exist. Rename file"
                        read new_file_name
                    done
                    ln "$trash_file" "$PWD/$new_file_name" 2> temp
                fi

            else
                echo "This dirrectory doesn't exist"
                ln "$trash_file" "$HOME/$new_file_name" 2> temp
            fi

            if [ -z $(cat temp) ]
            then
                cat "$trash_log" | grep -v "$current_file" > $trash_log
                rm "$trash_file"
                rm temp
            else
                echo "Can't create hard link"
                rm temp
                exit "1"
            fi
        fi
    fi
done 3< "$trash_log"