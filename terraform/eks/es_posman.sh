#!/bin/sh

ES_ENDPOINT="search-dev-eks-4bmjxccddeuhjabo3dg7w5wpce.us-east-1.es.amazonaws.com"
FLUENT_BIT_ROLE_ARN="arn:aws:iam::148302398499:role/dev-eks-logging"

curl -sS -u "admin:gU<jV5e-e7>{jmYM" -X PATCH \
  https://${ES_ENDPOINT}/_opendistro/_security/api/rolesmapping/all_access?pretty \
    -H 'Content-Type: application/json' \
    -d'
[
  {
    "op": "add", "path": "/backend_roles", "value": ["'${FLUENT_BIT_ROLE_ARN}'"]
  }
]'