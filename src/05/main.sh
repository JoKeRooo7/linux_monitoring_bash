#!/bin/bash

start_time=$(date +%s.%N)

if [[ "$OSTYPE" != *"linux"* ]]; then
  echo "Use Ubuntu Server 20.04 LTS"
  exit
fi

if [ -z "$1" ]; then
  echo "Attach the path as an argumentt"
  exit
fi

if [ ! -d "$1" ]; then
  echo "The path does not exist"
  exit
fi


number_of_folders=$(sudo find $1 -type d | wc -l)
folder_sizes=$(sudo du -h  "$1" | sort -hr)
number_of_files=$(sudo find "$1" -type f | wc -l)
number_of_conf=$(sudo find "$1" -type f -name "*.conf" | wc -l)
number_of_txt=$(sudo find "$1" -type f -name "*.txt" | wc -l)
number_of_executable=$(sudo find "$1" -type f -executable | wc -l)
number_of_log=$(sudo find "$1" -type f -name "*.log" | wc -l)
number_of_archives=$(sudo find "$1" -type f -iregex '.*\.\(zip\|tar\|gz\|bz2\|xz\|7z\|rar\|z\|iso\|dmg\)' | wc -l)
number_of_symbolic_links=$(sudo find "$1" -type l | wc -l)
file_sizes=$(sudo find "$1" -type f -exec du -h {} + | sort -hr)
file_sizes_exec=$(sudo find "$1" -type f -executable -exec du -h {} + | sort -hr)

output_of_top_folders() {
  count=0
  while [ $count -lt "$2" ]; do
    read -r line
    size=$(echo "$line" | awk '{print $1}')
    way=$(echo "$line" | awk '{print $2}')
    if [ "$way" != "" ]; then
      echo "$((++count)) - $way, $size"
    else 
      echo "$((++count)) - It's empty"
    fi
    
  done <<< "$1"
}

echo "Total number of folders (including all nested ones) = $number_of_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"

output_of_top_folders "$folder_sizes" "5"

echo "Total number of files = $number_of_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $number_of_conf"
echo "Text files = $number_of_txt"
echo "Executable files = $number_of_executable"
echo "Log files (with the extension .log) = $number_of_log"
echo "Archive files = $number_of_archives"
echo "Symbolic links = $number_of_symbolic_links"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"

output_of_top_folders "$file_sizes" "10"

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"

count=0
while [ $count -lt 10 ]; do
  read -r line
  size=$(echo "$line" | awk '{print $1}')
  way=$(echo "$line" | awk '{print $2}')
  if [ "$way" != "" ]; then
    hash=$(md5sum "$way" | awk '{print $1}')
    echo "$((++count)) - $way, $size, $hash"
  else 
    echo "$((++count)) - It's empty"
  fi
done <<< "$file_sizes_exec"

end_time=$(date +%s.%N)

echo "Script execution time (in seconds) = $(printf "%.1f" "$(echo "$end_time - $start_time" | bc)")"
