#!/bin/bash

source "$(dirname "$0")/../loader.sh"

OUT=$1
mkdir -p $OUT/portscan

print_status "Using Naabu and NMAP for port sacn..."
cat $OUT/resolved/resolved.txt | naabu -silent -top-ports 1000 -o $OUT/portscan/naabu.txt

# Optional deeper scan
# naabu -l $OUT/resolved/resolved.txt -p- -o $OUT/portscan/naabu.txt

# Optional: Nmap service scan on open ports
nmap -iL $OUT/resolved/resolved.txt -p- -T4 -A -oN $OUT/portscan/nmap.txt
print_done
