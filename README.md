# docker-mlflow

This repository contains a Dockerfile for [MLflow Tracking](https://github.com/mlflow/mlflow)

## Information

* Install [Docker](https://www.docker.com/)
* Install [Docker Compose](https://docs.docker.com/compose/install/)
* Uses Python (3.7-slim-stretch) official Image [python:3.7-slim-stretch](https://hub.docker.com/_/python/)
* and uses the official [Postgres](https://hub.docker.com/_/postgres/)
* and uses the official [Minio](https://hub.docker.com/_/minio/minio/) as backend.

## Running the docker-compose

Create a file named .env in the directory and set the values like the following:

````bash
# .env file

# Postgres
POSTGRES_USER=mlflow
POSTGRES_PASSWORD=mlflow
# S3
AWS_BUCKET=myBucket
AWS_ACCESS_KEY_ID=myAwsAccessKeyId
AWS_SECRET_ACCESS_KEY=myAwsSecretAccesKey
````

**Build:**

```
docker build --rm -t tk/docker-mlflow .
```

**Run:**

```
docker-compose up
```
