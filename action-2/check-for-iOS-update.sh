#!/bin/bash

appleSecurityReleasesURL="https://support.apple.com/en-us/HT201222"

latestiOSVersion=$(curl -s "$appleSecurityReleasesURL" | grep "The latest version of iOS" | grep -Eo "[0-9]{2}([.][0-9]){1,2}")
latestVersionData=$(curl -s "$appleSecurityReleasesURL" | grep -A 2 "iOS $latestiOSVersion")
lastUpdate=$(echo "$latestVersionData" | grep -Eo "[0-9]{2} [A-Z][a-z]{2} [0-9]{4}")

# lastUpdate=$(curl -s https://jamf-patch.jamfcloud.com/v1/software/macos | grep lastModified | awk -F ": " '{ print $2 }' | tr -d '",')
lastUpdateInSeconds=$(date -j -f "%d %b %Y" "$lastUpdate" "+%s")
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
