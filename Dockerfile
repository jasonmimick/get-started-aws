# syntax=docker/dockerfile:1.0.0-experimental
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    make \
    git \
    wget \
    curl \
    zip \
    golang \
    python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN wget --quiet https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz \
#&& tar -xf go1.15.3.linux-amd64.tar.gz \
#&& mv go /usr/local && chmod +x /usr/local/go

#RUN pip install --upgrade pip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install

RUN pip3 install cloudformation-cli-go-plugin

ENV WORKSPACE /workspace
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh,id=github git clone --single-branch --branch develop git@github.com:aws-quickstart/quickstart-mongodb-atlas.git
RUN --mount=type=ssh,id=github git clone git@github.com:aws-quickstart/quickstart-mongodb-atlas-resources.git

# copy the repository form the previous image
#COPY --from=intermediate /quickstart-mongodb-atlas /workspace/quickstart-mongodb-atlas
#COPY --from=intermediate /quickstart-mongodb-atlas-resources /workspace/quickstart-mongodb-atlas-resources
# ... actually use the repo :)

# Pre build everything
RUN cd /quickstart-mongodb-atlas-resources/cfn-resources/ && BUILD_ONLY=true ./cfn-submit-helper.sh



ENTRYPOINT ["/bin/bash", "-c"]  
