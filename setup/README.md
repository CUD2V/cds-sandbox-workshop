# CDS-Sandbox Setup

### Install virtual machine with Ubuntu server 20.04

- Create a user ```cds-user```. The home folder ```/home/cds-user``` for this user is used by the instruction below and also the scripts. 

### Update OS
```
sudo apt update -y && sudo apt dist-upgrade -y
```

### Install Lubuntu desktop
```
sudo apt install lubuntu-desktop -y
sudo systemctl set-default graphical.target
```
- Reboot to get the changes to take effect

### Install Java OpenJDK 11
```
sudo apt install openjdk-11-jdk-headless -y
```
```
echo "
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 
PATH=${JAVA_HOME}/bin:${PATH}
export JAVA_HOME
export PATH
" | sudo tee -a ~/.bashrc
```
```
. ~/.bashrc
```

### Install packages
```
sudo apt install curl maven gradle -y
```

### Install Node 14
```
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt update
sudo apt -y install nodejs
```

### Install Docker and docker-compose
```
sudo snap install docker 
sudo apt install docker-compose -y
```

### Add user to docker group
```
sudo usermod -aG docker ${USER}
```

- Enter ```su - ${USER}``` to get the change to take effect

### Install Yarn
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update -y && sudo apt install yarn -y
```

### Install Visual Studio Code
- Note: We changed from Atom to VSCode
```
sudo snap install --classic code
```

- Install CQL plugin
```
code --install-extension cqframework.cql
```

### Clone CDS-Sandbox repository
```
sudo apt install git
git clone https://github.com/cud2v/cds-sandbox.git	
```

### Add Aliases to .bashrc
```
cat ~/cds-sandbox/scripts/aliases.sh | sudo tee -a ~/.bashrc
```

```
. ~/.bashrc
```

### Copy External CQL
```
cp ~/cds-sandbox/desktop/Workshop_External_CQL.zip ~/Desktop/
```

&nbsp;
# Install CDS-Sandbox Homepage

### Start container
```
cd 
cd cds-sandbox/homepage
docker-compose up -d
```

### Open URL: http://localhost

&nbsp;
# Install SMART DEV SANDBOX 

### Clone smart-dev-sandbox repository
```
cd
git clone https://github.com/smart-on-fhir/smart-dev-sandbox.git
cd smart-dev-sandbox
```

### Start docker
```
docker-compose up -d
```

### Open URL: http://localhost:4000/

&nbsp;
# Install AHRQ CDS Services

### Clone repository
```
cd
git clone https://github.com/AHRQ-CDS/AHRQ-CDS-Connect-CQL-SERVICES.git
cd AHRQ-CDS-Connect-CQL-SERVICES
```

### Install dependencies
```
yarn
```

### Add parameters _count and _sort by date so that recent resources are listed first. Create a separate case for Observation.      
```
nano ~/AHRQ-CDS-Connect-CQL-SERVICES/lib/hooks-loader.js
```

- Replace 
```
case 'Observation':
```

 - With

```
case 'Observation':
  return { [resource]: `${resource}?patient={{context.patientId}}&_count=9999&_sort:desc=date` };
```

### Build Docker
```
docker build -t cql-services .
```

### Add UMLS Account to .bashrc
```
echo "
export UMLS_USER_NAME=myusername
export UMLS_API_KEY=myapikey
" | sudo tee -a ~/.bashrc
```

```
. ~/.bashrc
```

### Run Docker
```
docker run --name cql-services -d -p "3000:3000" -e "UMLS_USER_NAME=${UMLS_USER_NAME}" -e "UMLS_API_KEY=${UMLS_API_KEY}" -e "CQL_SERVICES_MAX_REQUEST_SIZE=2mb" -v /home/cds-user/AHRQ-CDS-Connect-CQL-SERVICES/config:/usr/src/app/config cql-services:latest
```

### Open URL: http://localhost:3000

&nbsp;
# Install AHRQ CDS Authoring Tool

### Clone repository
```
cd
git clone https://github.com/AHRQ-CDS/AHRQ-CDS-Connect-Authoring-Tool.git
cd AHRQ-CDS-Connect-Authoring-Tool
```

### Change from ldap to local authentication
```
cd api
nano config.js
```

- For ldap, change ```default: true``` to ```default: false```.

- For local, change ```default: false``` to ```default: true```.

### Copy default user
```
cd ..
cp api/config/minimal-example.json api/config/local.json
cp api/config/example-local-users.json api/config/local-users.json
```

### Start docker
```
docker-compose up -d
```

### Open URL: http://localhost:9000
- To login, use ```username = demo``` and ```password = password```

&nbsp;
# Install CQL-to-ELM Translator
```
cd
wget https://github.com/cqframework/clinical_quality_language/archive/refs/tags/v1.5.2.zip
unzip v1.5.2.zip
rm v1.5.2.zip
```

### Build
```
cd clinical_quality_language-1.5.2/Src/java/cql-to-elm
../gradlew build
../gradlew :cql-to-elm:installDist
```

&nbsp;
# Install CDS-Hooks

### Clone repository
```
cd
git clone https://github.com/cds-hooks/sandbox.git
cd sandbox
```

### Add host: '0.0.0.0' to webpack.config.dev.js in devServer parameter
```
nano webpack.config.dev.js
```

### Copy Dockerfile from cds-sandbox/cds-hooks
```
cp ~/cds-sandbox/cds-hooks/Dockerfile ~/sandbox/
```

### Build docker
```
docker build -t cds-hooks .
```

### Run docker
```
docker run --name cds-hooks -d -it -p 8000:8080 cds-hooks
```

### Open URL: http://localhost:8000

&nbsp;
### Create shortcut pointing to local FHIR
```
http://localhost:8000/?fhirServiceUrl=http%3A%2F%2Flocalhost:4004%2Fhapi-fhir-jpaserver%2Ffhir&patientId=1
```

&nbsp;
# Install CQL-Results SMART on FHIR app

### Clone repository
```
cd
git clone https://github.com/andreysoares/cql-results.git
cd cql-results
```

### Install dependences
```
yarn
```

### Start docker
```
docker-compose up -d
```

### Open URL: http://localhost:3030

&nbsp;
# Configure Remote Access

### Install xrdp
```
sudo apt install xrdp -y
```

### Enable xrdp
```
sudo systemctl enable --now xrdp
```

### Open firewall port 3389
```
sudo ufw allow from any to any port 3389 proto tcp
```
