#!/bin/bash

# Fetch the latest XKCD comic number
latest_comic=$(curl -s https://xkcd.com/info.0.json | jq -r '.num')

# Generate a random comic number between 1 and the latest
random_comic=$((RANDOM % latest_comic + 1))

# Fetch the random comic's JSON metadata
comic_json=$(curl -s "https://xkcd.com/$random_comic/info.0.json")

# Extract the image URL
img_url=$(echo "$comic_json" | jq -r '.img')

# Extract the filename
img_filename=$(basename "$img_url")

# Define temporary file path
img_path="/tmp/$img_filename"

# Download the image
curl -s -o "$img_path" "$img_url"

# Display the image using feh
feh "$img_path"

# Delete the image after viewing
rm -f "$img_path"
