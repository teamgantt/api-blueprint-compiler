#!/bin/bash

# SET DEFAULT VALUES
RESET=1
DIRECTORY=$(PWD)
SEARCH="./*"
OUTPUT="/dev/null"

# GET VALUES FROM OPTIONS
while getopts d:o:r:s: option
do
  case "${option}"
    in
      d) DIRECTORY=${OPTARG};;
      o) OUTPUT=${OPTARG};;
      r) RESET=${OPTARG};;
      s) SEARCH=${OPTARG};;
  esac
done

# IF RESET IS TRUE, LET'S CLEAR THE CONTENT OF THE OUTPUT FILE (WHICH MAY ALREADY EXIST)
if [ $RESET == 1 ]
  then
    > "$OUTPUT"
fi

# FETCH RESULTS
cd "$DIRECTORY"
awk '/@StartBluePrint/,/@EndBluePrint/' $SEARCH | awk '!/@StartBluePrint/' | sed -e s/@EndBluePrint//g >> "$OUTPUT"
