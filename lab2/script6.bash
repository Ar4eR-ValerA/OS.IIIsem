#!/bin/bash
grep "VmRSS" /proc/*/status | sort -nrk2 | head -n 1 | tr "/" " " | awk {'printf("/proc: pid=%s, res=%s\n", $2, $4)'}
top -o "RES" | head -n 8 | tail -n 1 | awk {'printf("top: pid=%s, res=%s\n", $2, $7)'}