#!/bin/bash
echo $$ > .pid

result=1
operator="+"

usr1() {
    operator="+"
}
usr2() {
    operator="*"
}
sigterm() {
    echo "stop"
    rm .pid
    exit 0
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while true
do
    case $operator in
    "+")
        let result=$result+2
    ;;
    "*")
        let result=$result*2
    ;;
    esac
    echo $result
    sleep 1
done