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
            ;;
         
            Delete)
            echo "Delete records" 
            result=$(deleteVinyl)
            logToFile $result
            ;;   
        
            Search)
            echo "Search"
            result=$(findRecord)
            logToFile $result
            ;;
        
            UpdateName)
            echo "Update record names"
            result=$(UpdateName)
            logToFile $result
            ;;

            UpdateAmount)
            echo "Update record amounts"
            result=$(updateAmount)
            logToFile $result
            ;;   
        
            PrintAmount)
            echo "Print record amounts"
            result=$(PrintAmount)
            logToFile $result
            ;;
        
            PrintAll)
            echo "Print all records"
            result=$(findRecord)
            logToFile $result
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







