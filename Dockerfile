FROM repostnetwork/deploy-utils:latest

LABEL "com.github.actions.name"="AWS Glue Job Deploy"
LABEL "com.github.actions.description"="Deploy Glue Job"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="red"

ENV AWS_REGION "us-east-1"
ENV GLUE_TRIGGER_SCHEDULE "cron(0 0 * * ? *)"
ENV JOB_BOOKMARK_OPTION "job-bookmark-disable"
ENV CRAWLER_REQUIRED "false"
ENV CONNECTION_REQUIRED "false"
ENV CATALOG_CREATION_REQUIRED "false"
ENV GLUE_NUM_WORKERS "10"

COPY terraform /usr/src/terraform
COPY Makefile /usr/src
COPY deploy.sh /usr/local/bin/deploy

WORKDIR /usr/src

ENTRYPOINT [ "deploy" ]