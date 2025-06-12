#!/bin/bash

DOMAIN=$1
OUT=$2
mkdir -p $OUT/subdomains

subfinder -d $DOMAIN -silent -o $OUT/subdomains/subfinder.txt
amass enum -passive -d $DOMAIN -o $OUT/subdomains/amass.txt
assetfinder --subs-only $DOMAIN >> $OUT/subdomains/assetfinder.txt
cat $OUT/subdomains/*.txt | sort -u > $OUT/subdomains/all.txt
