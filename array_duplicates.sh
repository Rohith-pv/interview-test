#!/bin/bash

find_common_elements(){
  local -n arr1=$1
  local -n arr2=$2
  local -A seen
  local common=()

  for num in "${arr1[@]}"
  do
     seen[$num]=1
  done
  for num in "${arr2[@]}"
  do
      if [[ -n "${seen[$num]}" ]]
      then
        common+=("$num")
        unset seen[$num]
      fi
  done

  echo "${common[@]}"
}

# Example
arr1=(1 2 3 5 7 8 10 12 15)
arr2=(2 4 5 7 10 11 12 14 15)

result=($(find_common_elements arr1 arr2))

echo "common elements:"  ${result[@]}
