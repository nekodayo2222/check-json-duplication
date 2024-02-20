#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: First argument is missing."
  exit 1
fi

if [ ! -e "$1" ]; then
    echo "Error: Path does not exist."
    exit 1
fi

if [[ "$1" != *.json && "$1" != *.JSON ]]; then
    echo "File extension is not .json or .JSON."
    exit 1
fi

duplicates=$(jq -r '.[] | .' "$1" | sort | uniq -d | awk '{sub(/^\t/, ""); print $0 "("NR")"}')
duplicates=${duplicates//\",(/\" \(}

if [ -z "$duplicates" ]; then
    echo "No duplicate data found in the JSON file."
else
    echo "Duplicate data found in the JSON file:"
    echo "$duplicates"
fi

