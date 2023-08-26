#!/bin/bash
source globals/definitions.sh
source scripts/search/search.sh
source scripts/log/log.sh
source scripts/updates/updateAmount.sh
source scripts/menu.sh
source scripts/delete/delete.sh
source scripts/add/add.sh

DBFileName=$1

if [[ $# -lt 1 ]]
then
    echo "Invalid number of arguments while starting the program, terminating"
    exit
fi


searchDBFile $DBFileName
searchLogFile

#print_menu
##findRecord
<<<<<<< HEAD
#deleteVinyl $DBFileName
=======
addRecord $DBFileName
>>>>>>> 7e05ab78df429028f9185ab76749acc7a754b211

