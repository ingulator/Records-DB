#!/bin/bash

function logToFile(){
    #date '+%Y-%m-%d %H:%M:%S' -a echo $1 >> $logFilePath$logFileName
    printf '%s %s\n' "$(date '+%d-%m-%Y %H:%M:%S')" "$1" >> $logFilePath$logFileName
}