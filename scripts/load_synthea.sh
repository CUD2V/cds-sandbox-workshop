#!/bin/bash

declare -a service_dir=(`ls ~/cds-sandbox/sample_patients/*`)

length=${#service_dir[@]}

for (( j=0; j<length; j++ ));
do
  entry=${service_dir[$j]}
  IFS='/' read -ra items <<< "$entry"
  len=${#items[@]}-1 
  printf "%2d - %s...\n" $j "${items[$len]:0:25}"
  curl http://localhost:4004/hapi-fhir-jpaserver/fhir --data-binary "@${entry}" -H "Content-Type: application/fhir+json" &> /dev/null
done

echo "####################################"
echo "Restart the HAPI FHIR Docker"
