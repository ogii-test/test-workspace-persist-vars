#!/bin/bash
#Script to generate vars to be used in Slack notifications

API_URL="gh/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/$CIRCLE_BUILD_NUM"

sleep 1s

BUILD_INFO=$(curl -X GET -H "Circle-Token: $CIRCLECI_TOKEN" -H "Content-type: application/json" "https://circleci.com/api/v1.1/project/${API_URL}")
#FAILED_STEP BUILD_INFO=$(curl -X GET -H "Circle-Token: $CIRCLECI_TOKEN" -H "Content-type: application/json" "https://circleci.com/api/v1.1/project/${API_URL}" | jq '.steps | .[] | flatten | map(select(.status? == "failed")) | .[] | {allocation_id, step, name}')
FAILED_STEP=$(echo $BUILD_INFO | jq '.steps | .[] | flatten | map(select(.status? == "failed")) | .[] | {allocation_id, step, name}')
echo $BUILD_INFO
echo $FAILED_STEP

echo 'export ALLOCATION_ID=$(echo "${FAILED_STEP}" | jq -r ".allocation_id")' >> $BASH_ENV
STEP=$(echo "${FAILED_STEP}" | jq -r ".step") && echo 'export STEP=$(echo "${FAILED_STEP}" | jq -r ".step")' >> $BASH_ENV
NAME=$(echo "${FAILED_STEP}" | jq -r ".name") && echo 'export NAME=$(echo "${FAILED_STEP}" | jq -r ".name")' >> $BASH_ENV
#echo 'export API_URL=$(echo $CIRCLE_BUILD_URL | cut -d/ -f4-7)' >> $BASH_ENV
#echo 'export COMMITTER_NAME=$(echo $BUILD_INFO | tail -n23 | grep committer_name | cut -f2- -d: | grep -o -P "(?<=\").*(?=\")")' >> $BASH_ENV
COMMITTER_NAME=$(echo $BUILD_INFO | tail -n23 | grep committer_name )
echo $COMMITER_NAME
echo $COMMITTER_NAME >> envars.txt
#echo $CIRCLE_API_TOKEN  >> envars.txt
#echo $ALLOCATION_ID  >> envars.txt
#echo $FAILED_STEP  >> envars.txt
echo $STEP  >> envars.txt
echo $NAME  >> envars.txt
echo $THE_FAILED_STEP  >> envars.txt
cat envars.txt
 
