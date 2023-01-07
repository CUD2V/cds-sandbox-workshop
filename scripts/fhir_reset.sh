#!/bin/bash

systemctl restart docker.service

echo "### Stop FHIR container"
docker stop hapi-r4
echo "### Remove FHIR container"
docker rm hapi-r4
echo "### Remove FHIR volume"
docker volume rm smart-dev-sandbox_r4-database

echo "### Start FHIR container"
cd ~/smart-dev-sandbox
docker-compose up -d

echo "####################################"
echo "You need to run load_synthea to add the sample patients."

