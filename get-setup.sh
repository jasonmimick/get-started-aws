#!/usr/bin/env bash

echo "Creating get-started-aws Docker volume ... "
docker volume create get-started-aws
echo "Setting up environment ..."
docker run --rm \
    -v $HOME/.aws:/root/.aws \
    -v get-started-aws:/cache \
    -v "$(pwd)":/workspace \
    -w /workspace/atlas-aws atlas-aws \
     "ls -l /; \
     ls -l /quickstart-mongodb-atlas-resources/; \
     cd /quickstart-mongodb-atlas-resources/cfn-resources/; \
     ls -l .; \
     echo 'Registering and deploying MongoDB Atlas AWS CloudFormation Resources, this may take a while ...';
     SUBMIT_ONLY=true ./cfn-submit-helper.sh
     echo 'You can now execute get-started.sh <Quickstart_Name>';"
