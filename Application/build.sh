#!/bin/bash

PROFILE=
REGION=
FUNCTION_NAME=
ZIP_FILE=

# Initialize
if [ ! -f go.mod ]; then
    go mod init app-name
fi

go mod tidy
if [ $? -ne 0 ]; then
    echo “Mod tidy failed.”
    exit 1
fi

# Compile 
GOOS=linux GOARCH=amd64 go build -tags lambda.norpc -o bootstrap main.go
if [ $? -ne 0 ]; then
    echo “Go build failed.”
    exit 1
fi

# ZIP
zip -r duplicateCampaign.zip .
if [ $? -ne 0 ]; then
    echo “Failed to ZIP file.”
    exit 1
fi

mv duplicateCampaign.zip ../tmp/

# Deploy
 aws lambda update-function-code \
     --function-name $FUNCTION_NAME \
     --zip-file fileb://$ZIP_FILE \
     --profile $PROFILE \
     --region $REGION

 if [ $? -eq 0 ]; then
     echo “Deployment successful.”
 else
     echo “Deployment failed.”
     exit 1
 fi

 # Cleanup
 rm bootstrap $OUTPUT_FILE

exit 0
