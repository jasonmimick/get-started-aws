# Get-Started AWS

Repository to help getting started with using MongoDB Atlas with AWS CloudFormation.

## Information

This Get-Started project uses the [MongoDB Atlas AWS Quick Start]() and the [MongoDB Atlas CloudFormation Resources]().

## Pre-requisites 

### Docker 

Have Docker running on your machine. You can download and install from: https://docs.docker.com/install/

### MongoDB Atlas

In order to execute the code example, you need to have: 

* Create an organizational-level [MongoDB Atlas Programmatic API](https://docs.atlas.mongodb.com/configure-api-access#programmatic-api-keys). The key needs `Project Creator` permissions.
* The aws cli setup and configured on your development machine. 

##  Execution Steps 

1. Optional - not required unless needing to refesh with latest resource source code.
   Build Docker image with a tag name. Within the top level directory execute: 
  ```
  docker build . -t atlas-aws
  ```
   This will build a docker image with a tag name `atlas-aws`. 

2. Execute the helper shell setup script. This will package and deploy the MongoDB Atlas CloudFormation resources into your current default AWS region. 
  ```
  ./get-setup.sh
  ```

  Optionally, to set the region:
  ```
  AWS_DEFAULT_REGION=eu-west-3 ./get-setup.sh <PUBLIC_KEY> <PRIVATE_KEY> <ORG_ID>
  ```
  Note this step can take up to 45 minutes to run.
  Run this step once in each region you wish to use.

3. Execute the helper shell starter script by providing the Quick Start name. The output from `get-setup.sh` helper script will inform you of the details for your new MongoDB Atlas deployment, including AWS AIM Role and Cluster connection string information for you apps. Note this step takes 7-10 minutes. 
  ```
  ./get-started.sh <Quick Start-Name>
  ```
Once successful, you should be able to access your new deployment through the AWS console, the Atlas console or even the clis.

## Tear Down 

How to remove the environment setup (deleting traces of this get-started project):

* Delete the Quick Start stack using the helper script or you can do this in the AWS Web Console or cli yourself.
  ```
  ./teardown.sh <Quick Start-Name>
  ```

* Terminate the `get-started.sh` process if it's running. This is to stop the web service on `localhost:3000`.
* Delete the CloudFormation stack created, by default this will have the <Quick Start-Name>:
   ```
   aws cloudformation delete-stack --stack-name <Quick Start-Name>
   ```
* Remove the Docker volumes
* Remove the Docker image

## Tutorials

TODO - add links to repos, example stacks, using this with lambda

## About 

This project is part of the MongoDB Get-Started code examples. Please see [get-started-readme](https://github.com/mongodb-developer/get-started-readme) for more information. 


## Notes

To build the container - need this:
```
export DOCKER_BUILDKIT=1
docker build --ssh github=$HOME/.ssh/id_rsa -t atlas-aws .
```
