#!/bin/bash

source "(dirname "$0")/../loader.sh"

OUT=$1
mkdir -p $OUT/fuzz

print_status "Directory fuzzing..."
# Directory fuzzing
while read url; do
	ffuf -u "$url/FUZZ" -w /usr/share/seclists/Discovery/Web-Content/common.txt -mc 200,204,301,302,307,403 -t 50 -of csv -o $OUT/fuzz/ffuf-$(echo $url | awk -F/ '{print $3}').csv
done < $OUT/live/live.txt
print_done

print_status "Using arjun for param brute force..."
# Param brute force
while read url; do
	arjun -u "$url" -o $OUT/fuzz/arjun-params.txt
done < $OUT/params/all-urls.txt
print_done
