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

echo "Try run script..."

while ! node dist
do
    echo "Script failed, retry after 60 seconds..."
    timestamp=$(expr $timestamp + 60)
    sleep 60
done

echo "The script was executed successfully"

echo $timestamp >$file