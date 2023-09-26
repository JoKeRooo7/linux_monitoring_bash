#!/bin/bash

echo "checking utils"

username=$(whoami)
sudo usermod -aG sudo $username >/dev/null 2>&1                                  # 2 - stderr, 1 - stdout, 0 - stdin

check_and_install() {
  if ! dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -q "installed" ; then   # -W результат только для этого пакета -f='${Status}' вывести только статус и ищет у этого вывода installed
    sudo apt-get install $1 >/dev/null 2>&1
    echo "install $1 done"
  fi

}

check_and_install "net-tools"
check_and_install "bc"

echo -e "checking done\n"
sleep 1
clear
