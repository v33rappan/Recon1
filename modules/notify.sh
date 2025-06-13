#!/bin/bash
OUT=$1
source config.conf
[ -f "$OUT/nuclei/findings.txt" ] && cat $OUT/nuclei/findings.txt | notify
[ -f "$OUT/xss/dalfox.txt" ] && cat $OUT/xss/dalfox.txt | notify
