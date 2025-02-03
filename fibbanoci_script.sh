#!/bin/bash

a=1
b=2
sum=0
count=0

echo "calculate sum of first 100 even num"
while [ $count -lt 100  ]
do
  if [ $((b %2)) -eq 0 ]
  then
      sum = $((sum +b))
      count=$(( count +1 ))
  fi

    fib=$((a+ b))
    a=$b
    b=$fib
 done 

 echo "sum of first 100 even fib numbers is: " $sum
