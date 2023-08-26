#!/bin/bash

function deleteVinyl()
{

albumName1=$(findRecord)

if [[ $albumName1 == "No results found" ]]
then
    echo $albumName1
    echo "Returning to Main Menu."
    exit
fi


local albumAmount="`echo $albumName1 | rev | cut -d ' ' -f 1 | rev`"
echo THIS IS CURRENTY AMOUTNT $albumAmount

if [[ $currentAmount -eq 1 ]]
then
    #sed -i "s/oldstr/newstr/g"
    sed -i -e "/$albumName1/d" $DBFilePath$DBFileName
    echo "Record deleted"
    #TODO:LOG TO FILE PLS
else
    updateAmount "-d" "$albumName1" "$albumAmount"
    echo "Delete successful"
fi
}
