#! /bin/bash

menu=("ADD" "UPDATE AMOUNT" "UPDATE NAME" "DELETE")

function searchDBFile()
{
    if [[ -f $DBFilePath$DBFileName ]]
    then
        #echo db found
    else
        echo "Database not found, creating a new file named $1"
        touch DB/$1
    fi
}

function searchLogFile()
{
    if [[ -f $logFilePath$logFileName ]]
    then
        #echo log found
       
    fi
}

function findRecord()
{
	if [[ $1 == "-add" ]] 
	then
		read -p "Please enter Vinyl name that you wish to add: " vinyl
	else
		read -p "Please enter Vinyl name: " vinyl
	fi
    flag=1
    while [ $flag -eq 1 ]
    do
        if [ ${#vinyl} -ge 3 ]
        then
            flag=0
        else 
            echo "Not enough letters, Please enter again"
        fi
    done

    #searchResults="`grep -i $vinyl DB/recordsDB.csv | cut -d "," -f 1`"
    searchResults="`grep -i "$vinyl" DB/recordsDB.csv | sed 's/,/ /g' | sort`"
    resultAmount="`grep -i "$vinyl" DB/recordsDB.csv | sed 's/,/ /g' | sort | wc -l`"
    IFS=$'\n' 

    if [[ $resultAmount -gt 1 ]]
    then
        select i in $searchResults
        do
            echo $i
            return "Success"
        done
    elif [[ $resultAmount -eq 1 ]]
    then
        echo $searchResults
        return "Success"
    else
	echo  "$vinyl, No results were found"
        return "Success"
    fi    
}



