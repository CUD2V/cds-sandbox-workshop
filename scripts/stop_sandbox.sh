#!/bin/bash

echo "####################################"
echo "### CDS-Sandbox"
echo "####################################"

cd ~/cds-sandbox/homepage
docker-compose stop

echo "####################################"
echo "### SMART Dev"
echo "####################################"

cd ~/smart-dev-sandbox
docker-compose stop

echo "####################################"
echo "### CQL Services"
echo "####################################"

cd ~/AHRQ-CDS-Connect-CQL-SERVICES
docker stop cql-services

echo "####################################"
echo "### CDS Authoring Tool"
echo "####################################"

cd ~/AHRQ-CDS-Connect-Authoring-Tool
docker-compose stop

echo "####################################"
echo "### CDS Hooks"
echo "####################################"

docker stop cds-hooks

echo "####################################"
echo "### CQL Results SMARTonFHIR app"
echo "####################################"

cd ~/cql-results
docker-compose stop

