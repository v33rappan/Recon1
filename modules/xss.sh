#!/bin/bash
OUT=$1
mkdir -p $OUT/xss
dalfox file $OUT/params/payloaded-xss.txt --deep-detect --silence --output $OUT/xss/dalfox.txt
