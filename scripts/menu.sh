#!/bin/bash


function print_menu(){

     options=("Add" "Delete" "Search" "UpdateName" "UpdateAmount" "PrintAmount" "PrintAll" "Quit") 
     PS3="select option: " 
while true
 do
    select option in "${options[@]}" 
    do
    case $option in
        
            Add)
            echo "Add records"
            result=$(addRecord)
            logToFile $result
            exit
            ;;
         
            Delete)
            echo "Delete records" 
            result = $(deleteVinyl)
            logToFile $result

            ;;   
        
            Search)
            echo "Search"
            result = $(findRecord)
            logToFile $result

            ;;
        
            UpdateName)
            echo "Update record names"
            ;;

            UpdateAmount)
            echo "Update record amounts"
            ;;   
        
            PrintAmount)
            echo "Print record amounts"
            ;;
        
            PrintAll)
            echo "Print all records"
            ;;  

            Quit)
            echo
            echo "Exiting program"
            exit
            ;; 
         *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
    done

done

}







