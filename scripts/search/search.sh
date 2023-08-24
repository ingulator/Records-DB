#! /bin/bash

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
    flag=1
    while [ $flag -eq 1 ]
    do
        read -p "Enter Vinyl name: " vinyl
        if [ ${#vinyl} -ge 3 ]
        then
            flag=0
        else 
            echo "Not enough letters, Please enter again"
        fi
    done
    #searchResults="`grep -i $vinyl DB/recordsDB.csv | cut -d "," -f 1`"
    searchResults="`grep -i $vinyl DB/recordsDB.csv | sed 's/,/ ---> /g' | sort`"
    resultAmount="`grep -i $vinyl DB/recordsDB.csv | sed 's/,/ ---> /g' | sort | wc -l`"


    IFS=$'\n' 


    if [[ $resultAmount -gt 1 ]]
    then
        select i in $searchResults
        do
            echo $i
            logToFile "Search success"
            break
        done
    elif [[ $resultAmount -eq 1 ]]
    then
        echo $searchResults
        logToFile "Search success"
    else
        echo "No results found"
        logToFile "Search failure"
    fi    
}



