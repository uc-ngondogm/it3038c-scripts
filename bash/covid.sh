#!/bin/bash
# This script downloads covid data and displays it

DATA=$(curl https://api.covidtracking.com/v1/us/current.json)
POSITIVE=$(echo $DATA | jq '.[0].positive')
NEGATIVE=$(echo $DATA | jq '.[0].negative')
PENDING=$(echo $DATA | jq '.[0].pending')
DEATH=$(echo $DATA | jq '.[0].death')
STATES=$(echo $DATA | jq '.[0].states')
TODAY=$(date)

echo "On $TODAY, there were $POSITIVE positive cases, $NEGATIVE negative tests, $PENDING pending results, $DEATH death,and $STATES states infected by COVID-19"
