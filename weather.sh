#!/bin/bash

script="$0"
DIRPATH="$(dirname $script)"

cd $DIRPATH

source .env

python3 measurements.py
