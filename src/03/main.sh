#!/bin/bash

if [[ "$OSTYPE" != *"linux"* ]]; then
  echo "Use Ubuntu Server 20.04 LTS"
  exit
fi

color_background() {
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
  else 
    echo "" 
  fi
}

color_value() {
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
  else 
    echo "" 
  fi
}

bnc=$(color_background "$1")     #background name color
nc=$(color_value "$2")      #name color
bvc=$(color_background "$3")     #background value color
vc=$(color_value "$4")      #value color

if [[ "$bnc" == "" || "$nc" == "" || "$bvc" == "" || "$vc" == "" ]]; then 
  echo "Invalid patametr"
elif [ "$1" == "$2" ]; then
  echo "Can 't be equal 1 and 2 arguments"
elif [ "$3" == "$4" ]; then
  echo "Can 't be equal 3 and 4 arguments"
else 
  ./output_linux.sh "$bnc" "$nc" "$bvc" "$vc" 
fi
