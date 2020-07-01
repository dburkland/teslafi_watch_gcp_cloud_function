#!/bin/bash
# Filename:             teslafi_watch_function_test.sh
# By:                   Dan Burkland
# Date:                 2020-05-09
# Purpose:              Validates the latest build of the TeslaFi Watch function. This is meant to be used in a CI/CD pipeline.
# Version:              1.0

# Variables
FUNCTION_NAME="request_handler"
TESLAFI_TOKEN="$1"

# Start the built-in functions-framework development server
nohup functions-framework --target $FUNCTION_NAME --port 38080 2>&1 1>/dev/null &
sleep 5

# Validate the function
CURL_OUTPUT=$(curl -s -o /dev/null -I -w "%{http_code}" http://localhost:38080?TOKEN=${TESLAFI_TOKEN})

# Kill functions-framework development server
pkill -f "functions-framework"

# Cleanup
if [ -f nohup.out ]; then
  /bin/rm -f nohup.out
fi

# Exit script with proper status code based on the test result
if [ "$CURL_OUTPUT" -eq "200" ]; then
  echo "teslafi_watch_gcp_cloud_function build test result: PASSED"
  exit 0
else
  echo "teslafi_watch_gcp_cloud_function build test result: FAILED"
  exit 1
fi
