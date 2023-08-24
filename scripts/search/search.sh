#! /bin/bash

menu=("ADD" "UPDATE AMOUNT" "UPDATE NAME" "DELETE")

function searchDBFile()
{
    if [[ -f $DBFilePath$DBFileName ]]
    then
        echo db found
    fi
}

function searchLogFile()
{
    if [[ -f $logFilePath$logFileName ]]
    then
        echo log found
    fi
}

function findRecord()
{
    read -p "Please enter album name: " album
   
    searchResults="`grep -i $album DB/recordsDB.csv | sed 's/,/ /g' | sort`"
    resultAmount="`grep -i $album DB/recordsDB.csv | sed 's/,/ /g' | wc -l`"
    IFS=$'\n' 


    if [[ $resultAmount -gt 1 ]]
    then
    select i in $searchResults
    do
        echo $i
        break
    done
    elif [[ $resultAmount -eq 1 ]]
    then
        echo "One search result was found: "
    else
        echo "No search results were found."
    fi
            
}



