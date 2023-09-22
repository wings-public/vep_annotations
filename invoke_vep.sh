#!/bin/bash

CMD=$1

if [[ $CMD == "Dummy" ]];then 
    echo "Dummy command"
    exit 0
else 
    perl "$CMD1"
fi
