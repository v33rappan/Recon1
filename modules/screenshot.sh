#!/bin/bash
OUT=$1
mkdir -p $OUT/screenshots
gowitness file -f $OUT/live/live.txt -P $OUT/screenshots/ --resolution 1280,800
