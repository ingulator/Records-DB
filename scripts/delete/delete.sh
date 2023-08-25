#!/bin/bash
source scripts/search/search.sh
amount=1

function deleteVinyl(){

albumName1=$(findRecord)
if [ $amount -eq 1 ]
then
    #sed -i "s/oldstr/newstr/g"
    sed -i -e "/$albumName1/d" $DBFilePath$DBFileName
    echo "Record deleted"
fi
}