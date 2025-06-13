#!/bin/bash
OUT=$1
mkdir -p $OUT/resolved
dnsx -silent -a -l $OUT/subdomains/all.txt -o $OUT/resolved/resolved.txt
