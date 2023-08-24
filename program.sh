#!/bin/bash
source globals/definitions.sh
source scripts/search/search.sh

DBFileName=$1

if [[ $# -lt 1 ]]
then
    echo "Invalid number of arguments while starting the program, terminating"
    exit
fi
    
#searchDBFile
#searchLogFile
findRecord


