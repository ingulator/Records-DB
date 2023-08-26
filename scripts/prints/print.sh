#!/bin/bash

function printTotal(){

    #local allRecords=$(grep -Eo '[0-9]{1,9}' $DBFilePath$DBFileName)
    local allRecords=( $(cat $DBFilePath$DBFileName | cut -d "," -f2) )
    local totalAmount=0
    
    #Validation
    if [ -z "$allRecords" ]
    then
      echo "There are no records in Database"
      return "Success"
    fi


    for line in ${allRecords[@]}
    do
        totalAmount=$((totalAmount+$line))

    done
    echo "There's a total of "$totalAmount" records"
    return "Success"
} 

function printSorted(){
    if ! [[ -s "$DBFilePath$DBFileName" ]]
    then
      echo "There are no records in Database"
      return "Success"
    else
      cat $DBFilePath$DBFileName | sort 
      return "Success"
    fi
}