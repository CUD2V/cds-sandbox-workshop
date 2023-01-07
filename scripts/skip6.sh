cp ~/cds-sandbox/rescue-files/step4/* ~/cql-results/src/data/R4 

echo -e "{\n\"CQLlibrary\": \"Statin-Use-Example\"\n}" > ~/cql-results/src/data/cql-files.json

cp ~/cds-sandbox/rescue-files/step5/valueset-db.json ~/cql-results/src/data/valueset-db.json

docker stop cql-services 

mkdir ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4

cp ~/cql-results/src/data/R4/CDS_Connect_Commons_for_FHIRv400.* ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4

cp ~/cql-results/src/data/R4/CDS_Connect_Conversions.* ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4

cp ~/cql-results/src/data/R4/FHIRHelpers.* ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4

cp ~/cql-results/src/data/R4/Million_Hearts_Baseline_10_Year_ASCVD_Risk_FHIRv400.* ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4

cp ~/cql-results/src/data/R4/Statin-Use-Example.* ~/AHRQ-CDS-Connect-CQL-SERVICES/config/libraries/statin-use-example-r4

cp ~/cds-sandbox/rescue-files/step6/statin-use-example-r4.json ~/AHRQ-CDS-Connect-CQL-SERVICES/config/hooks/statin-use-example-r4.json

docker start cql-services 

