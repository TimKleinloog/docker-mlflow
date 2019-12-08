FROM python:3.7-slim-stretch
LABEL maintainer="TK"

ENV MLFLOW_HOME /usr/local/mlflow
ENV MLFLOW_VERSION 1.4.0
ENV SERVER_PORT 5000

RUN useradd -ms /bin/bash -d ${MLFLOW_HOME} mlflow && \
    mkdir -p ${MLFLOW_HOME}/scripts && \
    pip install mlflow==${MLFLOW_VERSION} && \
    pip install psycopg2-binary && \
    pip install awscli --upgrade --user && \
    pip install boto3==1.10.34

COPY scripts/run.sh ${MLFLOW_HOME}/scripts/run.sh

RUN chown -R mlflow: ${MLFLOW_HOME} && \
    chmod +x ${MLFLOW_HOME}/scripts/run.sh

EXPOSE ${SERVER_PORT}/tcp

WORKDIR ${MLFLOW_HOME}

ENTRYPOINT ["./scripts/run.sh"]
