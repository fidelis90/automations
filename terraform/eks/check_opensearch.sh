#!/bin/sh

ES_DOMAIN_NAME="dev-eks"
AWS_PROFILE="ndx"
AWS_REGION="us-east-1"

command=`aws es describe-elasticsearch-domain --domain-name ${ES_DOMAIN_NAME} --profile ${AWS_PROFILE} ${AWS_REGION} us-east-1 --query 'DomainStatus.Processing'`

if [ ${command} == "false" ]
  then
    tput setaf 2; echo "The Amazon OpenSearch cluster is ready"
  else
    tput setaf 1;echo "The Amazon OpenSearch cluster is NOT ready"
fi
