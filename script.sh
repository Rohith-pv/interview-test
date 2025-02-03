#!/bin/bash

# This is sample input from some log
echo "
  192.168.1.1 -- [01/FEB/2025:10:15:32 +0000] "GET /index.html HTTP/1.1" 200 1024

" > access.log 

# extract all fields with HTTP request

awk '$9 >= 400 && $9 <= 599' access.log

# count occurance of HTTP
awk '{ print $6}' access.log | sed 's/"//g' | sort | uniq -c

# extract unique ip

awk '{ print $1 }' access.log | sort | uniq -c | sort -nr
