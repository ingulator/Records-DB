#! /bin/bash
source scripts/search/search.sh


function updateAmount()
{

albumName=$(findRecord)

if [[ $albumName == 'No search results were found.' ]]
then
    echo $albumName
    echo "Returning to Main Menu."
else
    #albumName= echo albumName
    read -p "Please enter new amount: " amount
    temp= printf '%s\n' "${albumName//[[:digit:]]/}"
    echo $temp
fi



    

}