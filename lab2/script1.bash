#!/bin/bash
ps -u user | sed '1d' > temp
cat temp | wc -l > file1.txt
cat temp | awk '{printf("%s: %s\n", $1, $4)}' >> file1.txt
rm temp