#!/bin/bash

sudo apt-get install dos2unix

dos2unix -c mac ../01/*.sh ../02/*.sh ../03/*.sh ../04/*.sh ../05/*.sh ../open_access/*.sh
