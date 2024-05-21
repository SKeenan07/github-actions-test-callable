#!/bin/bash

echo "Hello, World!"
echo "This is the script in action 1."

num=$(date +%d)

if (( $num % 2 )); then 
    echo "Date is odd"
    echo "date=odd" >> "$GITHUB_OUTPUT"
else 
    echo "Date is even"
    echo "date=even" >> "$GITHUB_OUTPUT"
fi