#!/bin/bash

compute_series_sum(){

    local x=$1
    local sum=0
    local term=0

    for i in {1..4}
    do
       term=$(( term * 10 + x ))
       sum=$(( sum + term))
     done

     echo $sum
}
X=3
result=$(compute_series_sum $X)

echo "Sum of series: "  $result
