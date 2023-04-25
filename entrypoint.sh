#!/usr/bin/env bash

echo "Start script:"
date

mkdir -p data/
file=data/lasttimestamp.txt

function get_last_timestamp() {
  if [ ! -f "$file" ]; then
    echo 0
  else
    cat $file
  fi

}

start_timestamp=$(get_last_timestamp)
random_offset=$(expr $RANDOM % 60 + 60)

timestamp=$(expr $start_timestamp + $random_offset)

echo "Wait $timestamp seconds"

sleep ${timestamp}

echo $timestamp >$file

echo "Try run script..."

if node dist; then
    echo "The script was executed successfully"
else
    echo "Script failed, retry"
    ./entrypoint.sh
fi