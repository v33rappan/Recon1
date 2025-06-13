#!/bin/bash

source "$(dirname "$0")/../loader.sh" 

DOMAIN=$1
OUT=$2
mkdir -p $OUT/subdomains

print_status "Running subfinder"
subfinder -d $DOMAIN -silent -o $OUT/subdomains/subfinder.txt &
pid=$!
spinner $pid
print_done

print_status "Running amass"
amass enum -passive -d $DOMAIN -o $OUT/subdomains/amass.txt &
pid=$!
spinner $pid
print_done

print_status "Running assetfinder"
assetfinder --subs-only $DOMAIN >> $OUT/subdomains/assetfinder.txt
print_done

wait

cat $OUT/subdomains/*.txt | sort -u > $OUT/subdomains/all.txt
