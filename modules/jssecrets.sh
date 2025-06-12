#!/bin/bash
OUT=$1
mkdir -p $OUT/js

# Find js files
cat $OUT/params/all-urls.txt | grep -Ei '\.js(\?|$)' | sort -u > $OUT/js/jsfiles.txt

# Download and scan for secrets
while read jsurl; do
	curl -s "$jsurl" | python3 SecretFinder.py -i --stdin -o cli >> $OUT/js/secrets.txt
done < $OUT/js/jsfiles.txt
