#! /bin/bash

menu=("ADD" "UPDATE AMOUNT" "UPDATE NAME" "DELETE")

function searchDBFile()
{
    if [[ ! -f $DBFilePath$DBFileName ]]
    then
        echo "Database not found, creating a new file named $1"
        touch DB/$1
    fi
}

function searchLogFile()
{
    if [[ ! -f $logFilePath$logFileName ]]
    then
        echo "log not found"
       
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
    

    if [[ $resultAmount -gt 1 ]]
    then
         IFS=$'\n'
        select i in $searchResults
        do
            echo $i
        done
        unset IFS
    elif [[ $resultAmount -eq 1 ]]
    then
        echo $searchResults
        return 1
    else
	echo  "$vinyl, No results were found"
        return 1
    fi    
}



