# Backup data from your Apigee Organisation(s)

This script leverages the apigee-migrate-tool https://github.com/apigeecs/apigee-migrate-tool to export data from Apigee org(s) and store the exported data in a git repo. The same script can be run regularly to store and track changes from each org in a git repo.

## Data Stored

Using the script you can store the following org data:
- developers
- proxies (latest version)
- shared flows
- flow hooks
- products
- apps
- app keys
- KVMs (org and env)
- Reports
- Spec store (Not available on-premises. Spec store APIs are in experimental status, so may change in the future)
- Target Servers

## Setup

1. Download and install Node.js at http://nodejs.org/download/.
1. Open a command prompt and install Grunt using the `npm` command.
    ```
    npm install -g grunt-cli
    ```
1. Duplicate this repository [see here for detailed instructions](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)
1. Make a directory at the repo root level for each apigee org you would like to backup. The folder name should match
exactly the name of the apigee org.
1. Modify .gitignore to whitelist the directories you created in the previous step.

Note: Protect your data by making the new repo private and restricting access.

## Usage
1. Execute ./backup-apigee-orgs.sh
1. Enter an Apigee username and password with access to the org(s) you will be backing up.

## Disclaimer
This is not an officially supported Google product.
