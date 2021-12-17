#!/bin/bash
ps -fe | grep -E "[[:space:]]+/sbin/" | awk '{printf("%s\n", $2)}' > file2.txt
