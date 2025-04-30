#!/bin/bash

CONFIG_FILE="sig.conf"

# Validate component name
read -p "Enter Component Name [INGESTOR/JOINER/WRANGLER/VALIDATOR]: " component
case $component in
  INGESTOR|JOINER|WRANGLER|VALIDATOR) ;;
  *) echo "Invalid component name."; exit 1 ;;
esac

# Validate scale
read -p "Enter Scale [MID/HIGH/LOW]: " scale
case $scale in
  MID|HIGH|LOW) ;;
  *) echo "Invalid scale."; exit 1 ;;
esac

# Validate view
read -p "Enter View [Auction/Bid]: " view
case $view in
  Auction|Bid) ;;
  *) echo "Invalid view."; exit 1 ;;
esac

# Validate count (single digit number)
read -p "Enter Count [0-9]: " count
if ! [[ "$count" =~ ^[0-9]$ ]]; then
  echo "Invalid count. Must be a single digit number."
  exit 1
fi

# Determine view string for config line
if [ "$view" == "Auction" ]; then
  view_str="vdopiasample"
else
  view_str="vdopiasample-bid"
fi

# Replace only the first matching line
found=0
tmp_file=$(mktemp)

while IFS= read -r line; do
  if [[ $found -eq 0 && $line == "$view_str ; $scale ; $component ; ETL ; vdopia-etl="* ]]; then
    echo "$view_str ; $scale ; $component ; ETL ; vdopia-etl= $count" >> "$tmp_file"
    found=1
  else
    echo "$line" >> "$tmp_file"
  fi
done < "$CONFIG_FILE"

mv "$tmp_file" "$CONFIG_FILE"
echo "Configuration updated successfully."
