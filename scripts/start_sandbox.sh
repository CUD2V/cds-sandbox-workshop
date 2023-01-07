#!/bin/bash

echo "####################################"
echo "### CDS-Sandbox"
echo "####################################"

cd ~/cds-sandbox/homepage
docker-compose up -d

echo "####################################"
echo "### SMART Dev"
echo "####################################"

cd ~/smart-dev-sandbox
docker-compose up -d

echo "####################################"
echo "### CQL Services"
echo "####################################"

cd ~/AHRQ-CDS-Connect-CQL-SERVICES
docker start cql-services

echo "####################################"
echo "### CDS Authoring Tool"
echo "####################################"

cd ~/AHRQ-CDS-Connect-Authoring-Tool
docker-compose up -d

echo "####################################"
echo "### CQL Results SMARTonFHIR app"
echo "####################################"

cd ~/cql-results
docker-compose up -d

echo "####################################"
echo "### CDS Hooks"
echo "####################################"

docker start cds-hooks

echo "####################################"
echo "### Starting Browser"
echo "####################################"

sensible-browser "http://localhost" &

exit