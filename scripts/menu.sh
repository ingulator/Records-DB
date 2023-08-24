#!/bin/bash

Function print_menu(){
     PS3="select option: "
     options=("Add" "Delete" "Search" "UpdateName" "UpdateAmount" "PrintAmount" "PrintAll")

while true
 do
    select options in "${options[@]}" 
    do
    case $option in
        
            Add_records)
            ;;
         
            Delete_records) 
            ;;   
        
            Search_records)
            ;;
        
            UpdateName_recodrs)
            ;;

            UpdateAmount_records)
            ;;   
        
            PrintAmount_records)
            ;;
        
            PrintAll_records)
            ;;   
            *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
    done

done

}

echo





