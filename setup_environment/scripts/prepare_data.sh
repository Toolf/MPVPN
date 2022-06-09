#!/bin/bash

for file in data/*tcp.log; do
    echo "$file"
    cat "$file" | tail -4 | head -1 | tr -s ' ' | cut -d' ' -f7
done