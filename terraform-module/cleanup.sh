#!/bin/bash

echo "Cleanup the IAM user and its keys and AWS ECR image"

IAM_USER_NAME="manager"
ECR_REPO="crewmeister-challenge"
REGION="us-east-1"

# Get access keys
ACCESS_KEYS=$(aws iam list-access-keys \
    --user-name "${IAM_USER_NAME}" \
    --query 'AccessKeyMetadata[].AccessKeyId' \
    --output text)

echo "Fetched Access Keys: ${ACCESS_KEYS}"

# Only continue if ACCESS_KEYS is not empty
if [ -n "$ACCESS_KEYS" ]; then
    for ACCESS_KEY in $ACCESS_KEYS; do
        echo "Deleting access key: $ACCESS_KEY"

        aws iam delete-access-key \
            --user-name "${IAM_USER_NAME}" \
            --access-key-id "${ACCESS_KEY}"
    done
else
    echo "No access keys to delete for user: ${IAM_USER_NAME}"
fi


####
####

# AWS ECR 

###
###
echo "Deleting all images from repository: $ECR_REPO"

# List all image digests
IMAGE_DIGESTS=$(aws ecr list-images \
  --region "$REGION" \
  --repository-name "$ECR_REPO" \
  --query 'imageIds[*].imageDigest' \
  --output text)

# Delete images if any exist
if [ -n "$IMAGE_DIGESTS" ]; then
  for digest in $IMAGE_DIGESTS; do
    echo "Deleting image: $digest"
    aws ecr batch-delete-image \
      --region "$REGION" \
      --repository-name "$REPO_NAME" \
      --image-ids imageDigest="$digest"
  done
else
  echo "No images found in the repository."
fi

echo " All images deleted!"
