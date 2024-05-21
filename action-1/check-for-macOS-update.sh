#!/bin/bash

lastUpdate=$(curl -s https://jamf-patch.jamfcloud.com/v1/software/macos | grep lastModified | awk -F ": " '{ print $2 }' | tr -d '",')
lastUpdateInSeconds=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$lastUpdate" "+%s")
echo "Last update: $lastUpdate ($lastUpdateInSeconds)"

currentSeconds=$(date "+%s")

oneWeekAgo=$(($currentSeconds - 604800))
echo "One week ago: $(date -j -f "%s" "$oneWeekAgo" "+%Y-%m-%dT%H:%M:%SZ") ($oneWeekAgo)"

if [[ $lastUpdateInSeconds -gt $oneWeekAgo ]]; then
    echo "Software updates are available" 
    echo "updates-available=true" >> "$GITHUB_OUTPUT"
else
    echo "No software updates are available" 
    echo "updates-available=false" >> "$GITHUB_OUTPUT"
fi
