#!/bin/bash
DOMAIN=$1
OUT=$2
mkdir -p $OUT/github

# Github dork and secret scanning
gitdorks_go -q "$DOMAIN password" -t "$GITHUB_TOKEN" > $OUT/github/gitdorks_go.txt
trufflehog github --org $DOMAIN --json > $OUT/github/trufflehog.json 
