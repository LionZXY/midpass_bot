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

increasing_delay=300
while ! node dist
do
    echo "Script failed, retry after ${increasing_delay} seconds..."
    timestamp=$(expr $timestamp + $increasing_delay)
    sleep $increasing_delay
    echo "Incresing delay is ${increasing_delay}"
    increasing_delay=$(expr $increasing_delay + $increasing_delay)
    if (( $increasing_delay > 30000 )); then
        echo "Sleep more than 1 day ($increasing_delay), so just exit"
        exit 1
    fi
done

echo "The script was executed successfully"

echo $timestamp >$file