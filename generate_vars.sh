#!/bin/bash
#Script to generate vars to be used in Slack notifications

API_URL="gh/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/$CIRCLE_BUILD_NUM"

sleep 1s

BUILD_INFO=$(curl -X GET -H "Circle-Token: $CIRCLECI_TOKEN" -H "Content-type: application/json" "https://circleci.com/api/v1.1/project/${API_URL}")
FAILED_STEP=$(echo $BUILD_INFO | jq '.steps | .[] | flatten | map(select(.status? == "failed")) | .[] | {allocation_id, step, name}')
STEP=$(echo "${FAILED_STEP}" | jq -r ".step")
echo "export STEP=${STEP}" | sudo tee -a $BASH_ENV
NAME=\"$(echo "${FAILED_STEP}" | jq -r ".name")\"
echo "export NAME=${NAME}" | sudo tee -a $BASH_ENV
COMMITTER_NAME=$(echo "${BUILD_INFO}" | tail -n23 | grep committer_name | cut -f2- -d: | cut -d\" -f2)
echo "export COMMITTER_NAME=${COMMITTER_NAME}" | sudo tee -a $BASH_ENV

echo $COMMITTER_NAME >> envars.txt
echo $STEP  >> envars.txt
echo $NAME  >> envars.txt
cat envars.txt
