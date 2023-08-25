#! /bin/bash
source scripts/search/search.sh


function updateAmount()
{

albumName=$(findRecord)

if [[ $albumName == 'No results found' ]]
then
    echo $albumName
    echo "Returning to Main Menu."
else

    #The new amount, checks whether amount is valid (greater than 1)
    read -p "Please enter new amount: " amount
    if [[ $amount -lt 1 ]]
    then
        echo "Invalid amount, amount cannot be less than 1"
        logToFile "Update amount failed, due to invalid input: less than 1."
        exit
    fi

    #Returns only the Album name, removing the amount from the row
    local temp="`printf '%s\n' "${albumName//[[:digit:]]/}" | sed 's/ *$//g'`"

    #Returns the number of row in which the record the user picked is located
    local rowNumForRecord="`awk -v var="$temp" '$0 ~ var{ print NR }' $DBFilePath$DBFileName`"
    
    #Return 
    sed -i -e "${rowNumForRecord}s/,.*/,$amount/" DB/recordsDB.csv

    

fi
}

    #val1=$( awk eval -v var=$temp '/$temp/{ print NR }' DB/recordsDB.csv )
    #awk -v var="$temp" '$0 ~ var{ print NR }' DB/recordsDB.csv

    #Returns only the amount number of the row
    #local currentAmount="`grep -i ^$temp DB/recordsDB.csv | xargs sed -i 's/,/,$amount/'`"
    # xargs cut -d "," -f 2 | xargs sed -i 's/[[:digit:]]/$amount/'`"

        
    #echo "123 $currentAmount"
    #grep -i $temp DB/recordsDB.csv | sed  