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
    #searchResults="`grep ^Abba DB/recordsDB.csv | sed 's/,.*/ /g'`"
    searchResults="`grep ^Abba DB/recordsDB.csv | cut -d "," -f 1`"
    resultAmount="`grep ^Abba DB/recordsDB.csv | cut -d "," -f 1 | wc -l`"

    IFS=$'\n' 


    if [[ $resultAmount -gt 1 ]]
    then
        select i in $searchResults
        do
            j=1
            eval "case \"$choice\" in
            $searchResults)             
            echo do something good here
            ;;
            *)
            echo invalid colour
            ;;
            esac"
        done
    fi    
}



