#!/bin/bash

if [[ "$1" =~ [0-9] ]]; then  # regular expressions only 
  echo "There is a number here ^O.O^"
else 
  echo "$1"
fi
