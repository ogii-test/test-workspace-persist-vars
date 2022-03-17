#!/bin/bash
#Script to generate vars to be used in Slack notifications

API_URL=$(echo $CIRCLE_BUILD_URL | cut -d/ -f4-7)
FAILED_STEP=$(curl "https://circleci.com/api/v1.1/project/${API_URL}?circle-token=${CIRCLE_API_TOKEN}" | jq '.steps | .[] | flatten | map(select(.status? == "failed")) | .[] | {allocation_id, step, name}')
echo 'export THE_FAILED_STEP=$FAILED_STEP' | sudo tee -a $BASH_ENV
echo 'export ALLOCATION_ID=$(echo "${FAILED_STEP}" | jq -r ".allocation_id")' | sudo tee -a $BASH_ENV
echo 'export STEP=$(echo "${FAILED_STEP}" | jq -r ".step")' | sudo tee -a $BASH_ENV
echo 'export NAME=$(echo "${FAILED_STEP}" | jq -r ".name")' | sudo tee -a $BASH_ENV
echo 'export API_URL=$(echo $CIRCLE_BUILD_URL | cut -d/ -f4-7)' | sudo tee -a $BASH_ENV
echo 'export COMMITTER_NAME=$( curl "https://circleci.com/api/v1.1/project/${API_URL}?circle-token=${CIRCLE_API_TOKEN}" | tail -n23 | grep committer_name | cut -f2- -d: | grep -o -P "(?<=\").*(?=\")")' | sudo tee -a $BASH_ENV
echo $COMMITTER_NAME
echo $CIRCLE_API_TOKEN
echo $ALLOCATION_ID
echo $FAILED_STEP
echo $STEP
echo $NAME
echo $THE_FAILED_STEP
