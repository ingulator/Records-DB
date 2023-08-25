#!/bin/bash
source scripts/search/search.sh

function addRecord() 
{
    read -p "Enter Vinyl name: " vinylName
    read -p "Enter Amount: " amount

    albumName=$(findRecord "$vinylName")

    if [[ -n "$albumName" ]] 
    then
        echo "Vinyl name exist"
        logToFile "Update Amount"
    else
        echo "$vinylName,$amount" >> "$DBFilePath$DBFileName"
        logToFile "Added record: $vinylName ($amount)"
    fi
}






