#!/bin/bash

function printTotal(){

    #local allRecords=$(grep -Eo '[0-9]{1,9}' $DBFilePath$DBFileName)
    local allRecords=( $(cat $DBFilePath$DBFileName | cut -d "," -f2) )
    local totalAmount=0
    
    #Validation
    if [ -z "$allRecords" ]
    then
      echo "There are no records in Database"
      return 1
    fi


    for line in ${allRecords[@]}
    do
        totalAmount=$((totalAmount+$line))

    done
    echo "There's a total of "$totalAmount" records"
    return 1
} 

function printSorted(){

    echo "$DBFilePath$DBFileName"
    if ! [[ -s "$DBFilePath$DBFileName" ]]
    then
      echo "There are no records in Database"
     
    else
      cat $DBFilePath$DBFileName | sort 
   fi
   return 1
}