#!/bin/bash
ps -eo pid,ppid,command | sed '1d' | sort -nr | awk -v proc=$$ '{if($1 != proc && $2 != proc) print}'| head -n 1