#!/bin/sh

set -e

if [ -z $BACKEND_STORE ]; then
  echo >&2 "BACKEND_STORE must be set"
  exit 1
fi

if [ -z $AWS_BUCKET ]; then
  echo >&2 "AWS_BUCKET must be set"
  exit 1
fi

if [ -z $AWS_ACCESS_KEY_ID ]; then
  echo >&2 "AWS_ACCESS_KEY_ID must be set"
  exit 1
fi

if [ -z $AWS_SECRET_ACCESS_KEY ]; then
  echo >&2 "AWS_SECRET_ACCESS_KEY must be set"
  exit 1
fi

mlflow server \
    --backend-store-uri $BACKEND_STORE \
    --default-artifact-root s3://${AWS_BUCKET}/artifacts \
    --host 0.0.0.0 \
    --port $SERVER_PORT
