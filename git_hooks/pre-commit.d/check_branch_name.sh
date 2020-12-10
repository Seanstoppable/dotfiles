#!/bin/bash

a=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
b=$(echo "$a" | awk '{print tolower($0)}')

if [[ ${a} != ${b} ]] 
then
  echo "Must have lowercase branch name"
 exit 1 
fi

if [[ ${a} == "master" ]]
then
  echo "You can't commit to master!"
  exit 1
fi
