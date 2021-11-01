FROM repostnetwork/deploy-utils:latest

LABEL "com.github.actions.name"="AWS Glue Job Deploy"
LABEL "com.github.actions.description"="Deploy Glue Job"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="red"

ENV AWS_REGION "us-east-1"
ENV GLUE_TRIGGER_SCHEDULE "cron(0 0 * * ? *)"

COPY terraform /usr/src/terraform
COPY Makefile /usr/src
COPY deploy.sh /usr/local/bin/deploy

WORKDIR /usr/src

ENTRYPOINT [ "deploy" ]