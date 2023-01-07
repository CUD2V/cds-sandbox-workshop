#!/bin/bash

echo " "
echo "WARNING:"
echo "  - This operation will reset the services and restore basic VM data."
echo "  - All data create by the user will be lost. "
echo " "
echo "Are you sure you want to proceed? "
read -p "Type Yes to continue or press Enter to exit: " option

if [ "${option}" == "Yes" ]
then
  echo "Reseting services..."
else
  echo "Exiting..."
  exit 1
fi

if [ -z ${UMLS_USER_NAME} ] || [ -z ${UMLS_API_KEY} ]
then
  echo "UMLS credentials are unset."
  exit 1
fi

echo "####################################"
echo "### Stop and Remove Containers"
echo "####################################"

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker volume rm smart-dev-sandbox_r4-database

echo "####################################"
echo "### CDS-Sandbox"
echo "####################################"

cd ~/cds-sandbox/homepage
docker-compose up -d

echo "####################################"
echo "### SMART Dev Sandbox"
echo "####################################"

cd ~/smart-dev-sandbox
docker-compose up -d

echo "####################################"
echo "### AHRQ-CDS-Connect-CQL-SERVICES"
echo "####################################"

cd ~/AHRQ-CDS-Connect-CQL-SERVICES
docker build -t cql-services .
docker run --name cql-services -d -p "3000:3000" -e UMLS_USER_NAME -e UMLS_API_KEY -e "CQL_SERVICES_MAX_REQUEST_SIZE=2mb" -v ~/AHRQ-CDS-Connect-CQL-SERVICES/config:/usr/src/app/config cql-services:latest

echo "####################################"
echo "### AHRQ-CDS-Connect-Authoring-Tool"
echo "####################################"

cd ~/AHRQ-CDS-Connect-Authoring-Tool
docker-compose up -d

echo "####################################"
echo "### CDS Hooks"
echo "####################################"

cd ~/sandbox
docker build -t cds-hooks .
docker run --name cds-hooks -d -it -p 8000:8080 cds-hooks

echo "####################################"
echo "### CQL Results"
echo "####################################"

cd ~/cql-results
docker-compose up -d

echo "####################################"
echo "### Starting Browser"
echo "####################################"

firefox "http://localhost" &

exit