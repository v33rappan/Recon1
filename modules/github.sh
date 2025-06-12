#!/bin/bash
DOMAIN=$1
OUT=$2
mkdir -p $OUT/github

# Github dork and secret scanning
gitdorks -d $DOMAIN -o $OUT/github/gitdorks.txt
trufflehog github --org $DOMAIN --json > $OUT/github/trufflehog.json 
