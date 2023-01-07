#!/bin/bash

docker stop cql-services 

echo "####################################"
echo "### Reseting Artifacts..."
echo "####################################"

rm -rf ~/cql-results/src/data/R4/Million_Hearts_Baseline_10_Year_ASCVD_Risk_FHIRv400.*
rm -rf ~/cql-results/src/data/R4/Statin-Use-Example.*

echo -e "{\n\"CQLlibrary\": \"Condition_and_Medication_Count_FHIRv400\"\n}" > ~/cql-results/src/data/cql-files.json

echo -e "{\n}" > ~/cql-results/src/data/valueset-db.json

rm -rf ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4
rm -rf ~/AHRQ-CDS-Connect-CQL-SERVICES/config/hooks/statin-use-example-r4.json

docker start cql-services
