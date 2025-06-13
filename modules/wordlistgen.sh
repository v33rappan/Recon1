#!/bin/bash
OUT=$1
mkdir -p $OUT/wordlists
cat $OUT/params/all-urls.txt | awk -F '{for(i=1;i<=NF;i++)print $i}' | sort -u > $OUT/wordlists/path.txt

# Optionally we can run cewl against main pages to get more words
