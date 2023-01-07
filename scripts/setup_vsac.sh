#!/bin/bash

if [ -z ${UMLS_USER_NAME} ] || [ -z ${UMLS_APY_KEY} ]
then
  echo "UMLS credentials are unset."
  return
fi

echo ""
echo "Stopping CQL Services docker container"
docker stop cql-services

echo ""
echo "Removing CQL Services docker container"
docker rm cql-services

echo ""
echo "Running CQL Services docker container"
docker run --name cql-services -d -p "3000:3000" -e "UMLS_USER_NAME=${UMLS_USER_NAME}" -e "UMLS_API_KEY=${UMLS_API_KEY}" -e "CQL_SERVICES_MAX_REQUEST_SIZE=2mb" -v ~/AHRQ-CDS-Connect-CQL-SERVICES/config:/usr/src/app/config cql-services:latest

