#! /bin/bash
function updateAmount()
{
if [[ $1 == "-d" ]]
then
    local tempAlbumName=$2
    echo this is tempAlbumName $tempAlbumName
    local tempAlbumAmount=$3
    echo this is tempAlbumAmount $tempAlbumAmount
    local amount=$(( $tempAlbumAmount-1 ))
    local rowNumForRecord="`awk -v var="$tempAlbumName" '$0 ~ var{ print NR }' $DBFilePath$DBFileName`"
    sed -i -e "${rowNumForRecord}s/,.*/,$amount/" DB/recordsDB.csv
else
    local albumName=$(findRecord)

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

        local albumAmount1="`echo $albumName | cut -d ' ' -f 1 | rev`"
        echo this is albumAmount $albumAmount1
        local temp="$albumName,$albumAmount1"
        #local currentAmount="`grep -i ^$temp DB/recordsDB.csv | xargs sed -i 's/[:digit:]/,$amount/'`"
        #Returns only the Album name, removing the amount from the row
        #local temp="`printf '%s\n' "${albumName//[[:digit:]]/}" | sed 's/ *$//g'`"
        echo $temp
        #Returns the number of row in which the record the user picked is located
        #local rowNumForRecord="`awk -v var="$temp" '$1=="var" { print NR }' $DBFilePath$DBFileName`"

        #Return 
        #sed -i -e "${rowNumForRecord}s/,.*/,$amount/" DB/recordsDB.csv
    fi
fi
}
