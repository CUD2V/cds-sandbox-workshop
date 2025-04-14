This respository contains material for the **Clinical Decision Support (CDS) Sandbox**: a cloud-based virtual machine created to facilitate Clinical Decision Support (CDS) developers and implementers in the use of FHIR- and CQL-based open-source tools and technologies for building and testing CDS artifacts. The GitHub repository contains instructions to build the CDS-Sandbox that was used for the hands-on exercise during the workshop at AMIA 2020 and 2021 Symposium.

**Publication**: Andrey Soares, Majid Afshar, Chris Moesel, Michael A Grasso, Eric Pan, Anthony Solomonides, Joshua E Richardson, Eleanor Barone, Edwin A Lomotan, Lisa M Schilling, Playing in the clinical decision support sandbox: tools and training for all, JAMIA Open, Volume 6, Issue 2, July 2023, ooad038, https://doi.org/10.1093/jamiaopen/ooad038


## Main Tools:
- **CDS Authoring Tool**: The AHRQ CDS Connect CDS Authoring Tool allows users to author CDS logic using a simple web-based interface and to export it as FHIR-based CQL libraries.
  
- **CQL Services**: CQL Services, also developed as part of the AHRQ CDS Connect project, enables integrators to easily expose CQL logic libraries over a CDS Hooks API.

- **CDS Hooks Sandbox**: The CDS Hooks Sandbox provides authors and integrators a way to test CDS Hooks API services using synthetic patient data.
  
- **CQL-to-ELM Translator**: The CQL-to-ELM translator converts CDS artifacts from the CQL format into an expression logical model (ELM) format that is easier for other applications to process.
  
- **SMART on FHIR Launcher**: The SMART on FHIR Launcher provides another approach for testing by allowing users to launch the CQL Results app and access synthetic patient data from the FHIR server.
  
- **CQL Results app**: A SMART on FHIR app was created to process the CQL libraries against synthetic patient data and display the results of the logic.
  
- **HAPI FHIR server**: The HAPI FHIR Server contains synthetic patient data, created with Synthea, that is used for testing the artifacts. It provides services over a standard FHIR interface.
  
- **VSAC**: Several services rely on the National Library of Medicine’s (NLM) Value Set Authority Center (VSAC) for searching and downloading value sets. The VSAC is the only service that is used inside the virtual machine (VM) but hosted outside of the VM.

## CDS-Sandbox 

### VM Build

- Instructions in the Setup folder

### Tutorial Materials

- Prerequisites
- Step 1: EXPLORE HAPI FHIR 
- Step 2: Creating artifact with CDS Authoring Tool
- Step 3: Mannually editign the artifact 
- Step 4: Translate CQL TO ELM 
- Step 5: Test artifacts
- Step 6: Setup CQL Artifacts in CQL Services
- Step 7: Test CDS Hooks 
