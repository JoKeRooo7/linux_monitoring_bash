#!/bin/bash

file_settings="settings.conf"

if [[ "$OSTYPE" != *"linux"* ]]; then
  echo "Use Ubuntu Server 20.04 LTS"
  exit
fi

check_fail() {
  if [ "$1" == "" ]; then
    echo "default"
  elif [[ "$1" -lt 1 || "$1" -gt 6 ]]; then
    echo "error"
  else 
    echo "$1"
  fi
}

color_b() {  # background
  if [ "$1" == "1" ]; then
    echo '47'
  elif [ "$1" == "2" ]; then
    echo '41'
  elif [ "$1" == "3" ]; then
    echo '42'
  elif [ "$1" == "4" ]; then
    echo '44'
  elif [ "$1" == "5" ]; then
    echo '45'
  elif [ "$1" == "6" ]; then
    echo '40'
  elif [ "$1" == "default" ]; then 
    echo "40"
  fi
}

color_v() {  # value
  if [ "$1" == "1" ]; then
    echo '37'
  elif [ "$1" == "2" ]; then
    echo '31'
  elif [ "$1" == "3" ]; then
    echo '32'
  elif [ "$1" == "4" ]; then
    echo '34'
  elif [ "$1" == "5" ]; then
    echo '35'
  elif [ "$1" == "6" ]; then
    echo '30'
  elif [ "$1" == "default" ]; then 
    echo "37" 
  fi
}


color_cw() { #converted in words
  if [ "$1" == "1" ]; then
    echo "(white)"
  elif [ "$1" == "2" ]; then
    echo "(red)"
  elif [ "$1" == "3" ]; then
    echo "(green)"
  elif [ "$1" == "4" ]; then
    echo "(blue)"
  elif [ "$1" == "5" ]; then
    echo "(purple)"
  elif [ "$1" == "6" ]; then
    echo "(black)"
  fi
}

color_cbw() { #converted backgrounds in words
  if [ "$1" == "default" ]; then
    echo "(black)"
  else
    echo "$(color_cw "$1")"
  fi
}

color_cvw() { #converted value in words
  if [ "$1" == "default" ]; then
    echo "(white)"
  else
    echo "$(color_cw "$1")"
  fi
}


bnc=$(check_fail $(grep -m1 "column1_background" "$file_settings" | cut -d "=" -f2))     #background name color
nc=$(check_fail $(grep -m1 "column1_font_color" "$file_settings" | cut -d "=" -f2))      #name color
bvc=$(check_fail $(grep -m1 "column2_background" "$file_settings" | cut -d "=" -f2))     #background value color
vc=$(check_fail $(grep -m1 "column2_font_color" "$file_settings" | cut -d "=" -f2))      #value color

if [[ "$bnc" == "error" || "$nc" == "error" || "$bvc" == "error" || "$vc" == "error" ]]; then 
  echo "Invalid patametr in $file_settings file"
elif [[ "$bnc" == "$nc" && "$bnc" != "default" ]]; then
  echo "Can 't be equal 1 and 2 arguments"
elif [[ "$bvc" == "$vc" && "$bvc" != "default" ]]; then
  echo "Can 't be equal 3 and 4 arguments"
else 
  ./../03/output_linux.sh $(color_b "$bnc") $(color_v "$nc") $(color_b "$bvc") $(color_v "$vc")\
  
  echo -e "\n"
  echo "Column 1 background = $bnc $(color_cbw $bnc)"
  echo "Column 1 font color = $nc $(color_cvw $nc)"
  echo "Column 2 background = $bvc $(color_cbw $bvc)"
  echo "Column 2 font color = $vc $(color_cvw $vc)"

fi
