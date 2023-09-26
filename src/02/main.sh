#!/bin/bash

if [[ "$OSTYPE" == *"linux"* ]]; then
  ./check_linux.sh
  ou=$(./output_info_linux.sh) 
else
  echo "Use Ubuntu Server 20.04 LTS"
  exit
fi

file_name=$(date +"%d_%m_%y_%H_%M_%S")


if [[ "$1" == "Y" || "$1" == "y" ]]; then
  echo "$ou"
  echo "$ou" > "$file_name.status"
elif [[ "$1" == "N" || "$1" == "n" ]]; then
  echo "$ou"
else 
  echo "$ou"	
  read -p  "Do you want to write to a file (Y/N)?:" answer 
  if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
    echo "$ou" > "$file_name.status"
  fi
fi
