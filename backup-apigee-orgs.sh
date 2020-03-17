#!/bin/bash
###################################################################################################################################################
# Note: Currently this script only backs up the 'test' environment of each org. 
# Adding functionality to backup each environment in an org is currently under development. 
###################################################################################################################################################

# Download apigee-migrate-tool and install its dependecies
git clone https://github.com/apigeecs/apigee-migrate-tool.git
cd apigee-migrate-tool
npm install

# Populate config.js with valid username and password
read -p 'Please enter a username for the Apigee org(s) to be backed up: ' username
echo -n Password: 
read -s password
sed -i -e 's/admin@google.com/'"$username"'/g' config.js
sed -i -e 's/SuperSecret123/'"$password"'/g' config.js

cd ..
# For each directory (dir name needs to be the be same as Apigee Org name) export all available data through apigee-migrate-tool
for d in */ ; do

    # Loop through orgs/folders excluding apigee-migrate-tool
    if [[ $d != apigee-migrate-tool/ ]]; 
    then
    
    # Update org entry in config.js with current org name
    ORG=$(echo $d | sed 's:/*$::')
    cd apigee-migrate-tool
    sed -i -e 's/org1/'"$ORG"'/g' config.js
    grunt exportAll -v
  
    cd data
  
    # Unzip contents of downloaded resources and delete zip files
    find . -name "*.zip" | xargs -P 5 -I fileName sh -c 'unzip -o -d "$(dirname "fileName")/$(basename -s .zip "fileName")" "fileName"'
    find . -name "*.zip" -type f -delete
    
    # Overwrite existing Org folder with latest content
    rm -rf ../../$ORG
    cp -a . ../../$ORG
  
    # Cleanup working dir and reset config.js
    cd ..
    rm -r data
    sed -i -e 's/'"$ORG"'/org1/g' config.js
  
    cd ../$ORG/
  
    # Commit downloaded files to git repo
    NOW=$(date +"%Y%m%d-%T")
    git add -A . --verbose
    git commit -m "$ORG $NOW" --verbose
  
    cd ..
  fi
done

# Cleanup and push changes to git repo
rm -rf apigee-migrate-tool
git push
