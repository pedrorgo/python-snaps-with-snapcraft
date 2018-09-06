#!/bin/bash
BRed='\033[1;31m'         # Red
Yellow='\033[0;33m'       # Yellow
Color_Off='\033[0m'       # Text Reset

if [ -z "$1" ]; then
    echo -e "${BRed}Error: ${Yellow}1 Argument missing. Snap project folder is mandatory. $Color_Off" 
    exit
fi

rm -rf $1/parts $1/prime $1/stage
