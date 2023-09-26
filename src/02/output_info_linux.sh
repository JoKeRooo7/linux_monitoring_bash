#!/bin/bash

hostname=$(hostname)                                           # cat /etc/hostname
timezone_utc=$(timedatectl show --property=Timezone --value)
timezone_num=$(date +%:::z)                                     # date --help or date +%:::z in console
user=$(whoami)
os=$(uname -mrs)
date=$(date +"%d %b %Y %H:%M:%S")
uptime=$(uptime -p)
uptime_sec=$(cut -d' ' -f1 /proc/uptime)
ip=$(ip a | grep -o -m1 "inet.*" | cut -d' ' -f2 | cut -d'/' -f1)                   # From one command to another, global IP - curl ifconfig.me
mask=$(ifconfig | grep -A1 "inet $ip" | grep -o -m1 "netmask .*" | awk '{print $2}')
gateway=$(ip route | grep default | awk '{print $3}')
memory_info=$(free -b | grep "Mem:")
converted=$((1024*1024*1024))
ram_total=$(echo "$memory_info" | awk '{print $2}')
ram_used=$(echo "$memory_info" | awk '{print $3}')
ram_free=$(echo "$memory_info" | awk '{print $4}')
ram_total=$(echo "scale=3; $ram_total / $converted" | bc)
ram_used=$(echo "scale=3; $ram_used / $converted" | bc)
ram_free=$(echo "scale=3; $ram_free / $converted" | bc)
ram_total=$(printf "%.3f" "$ram_total")
ram_used=$(printf "%.3f" "$ram_used")
ram_free=$(printf "%.3f" "$ram_free")
space_root=$(df -k / | awk 'NR==2 {print $2}') # Number of record = 2 стркоа 2
space_root_used=$(df -k / | awk 'NR==2 {print $3}')
space_root_free=$(df -k / | awk 'NR==2 {print $4}')
space_root=$(echo "scale=2; $space_root / 1024" | bc)
space_root_used=$(echo "scale=2; $space_root_used / 1024" | bc)
space_root_free=$(echo "scale=2; $space_root_free / 1024" | bc)
space_root=$(printf "%.2f" "$space_root")
space_root_used=$(printf "%.2f" "$space_root_used")
space_root_free=$(printf "%.2f" "$space_root_free")

echo "HOSTNAME = $hostname"
echo "TIMEZONE = $timezone_utc UTC $timezone_num" 
echo "USER = $user"
echo "OS = $os"
echo "DATE = $date"
echo "UPTIME = $uptime"
echo "UPTIME_SEC = $uptime_sec seconds"
echo "IP = $ip"
echo "MASK = $mask"
echo "GATEWAY = $gateway"
echo "RAM_TOTAL = $ram_total GB"
echo "RAM_USED = $ram_used GB"
echo "RAM_FREE = $ram_free GB"
echo "SPACE_ROOT = $space_root MB"
echo "SPACE_ROOT_USED = $space_root_used MB"
echo "SPACE_ROOT_FREE = $space_root_free MB"
