# vim: ft=dockerfile
#
# nodejs-aws-builder
# Docker image used to create cxontainers that will work for nodejs
# apps hosted in AWS whose builds need access to the following commands:
#
# - `node`
# - `aws` to interact with aws services and resources
# - `js` to parse responses from AWS
# - `sops` to unencrypt secrets
#
# This is particularly useful for AWS lambda builds
#
FROM shippingeasy/aws-cli-builder:1.15.85

ARG NODE_VERSION=8.11.4-r0

RUN apk -Uuv add               \
      nodejs=$NODE_VERSION     \
      nodejs-dev=$NODE_VERSION \
    && rm /var/cache/apk/*
