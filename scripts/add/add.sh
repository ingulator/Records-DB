#!/bin/bash
source scripts/search/search.sh

function addRecord() 
{
    read -p "Enter Vinyl name: " vinyl
    
    echo "vinil " $vinyl
    #TODO FIX IF
    if [[ -n "$vinyl" ]] 
    then
        echo "Vinyl name exist"
        logToFile "Update Amount"
        exit 1
    else
        echo "$vinyl,$amount" >> "$DBFilePath$DBFileName"
        logToFile "Added record: $vinyl ($amount)"
        exit 1
    fi
    #read -p "Enter Amount: " amount
}




