#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

ON_TEMPERATURE=$(jq --raw-output '.onTemperature // empty' $CONFIG_PATH)
OFF_TEMPERATURE=$(jq --raw-output '.offTemperature // empty' $CONFIG_PATH)
GPIO_NUMBER=$(jq --raw-output '.gpioNumber // empty' $CONFIG_PATH)
echo "Temperature at which the fan turns on: ${ON_TEMPERATURE}"
echo "Temperature at which the fan turns off: ${OFF_TEMPERATURE}"
echo "GPIO at which the fan works: ${GPIO_NUMBER}"

python3 -u ./script.py ${ON_TEMPERATURE} ${OFF_TEMPERATURE} "${GPIO_NUMBER}"