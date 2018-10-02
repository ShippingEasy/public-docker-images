# vim: ft=dockerfile
#
# aws-cli-builder
# Docker image used to create containers that will work for a common build
# scenario:  I need to leverage the aws cli for interacting with resources,
# jq to parse json responses, sops for secrets decryption and sed/awk in
# in a consistent way between macs and linux.
#
# This can be built on top of with different language runtimes for doing
# things like executing unit tests, packaging, etc...
#
# Some other expectations:
# - source code for the build will be mounted to /usr/local/src
# - the working directory should be /usr/local/src
# - /usr/local/bin should be on the path
# - /usr/local/src/bin should be on the path
# - /usr/local/src/ops/bin should be on the path

################################################################################
FROM alpine:3.8 as jq_installer
ARG JQ_VERSION=1.6_rc1-r1
RUN apk -Uuv add jq=$JQ_VERSION
################################################################################

################################################################################
FROM alpine:3.8 as sops_installer
ARG SOPS_VERSION=3.1.1
WORKDIR /tmp
RUN wget "https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux" \
    && chmod +x "sops-${SOPS_VERSION}".linux
################################################################################

################################################################################
FROM alpine:3.8
ARG AWS_CLI_VERSION=1.15.85
ARG STACKER_VERSION=1.4.1

# Set up path to include common executable locations
ENV PATH="/usr/local/src/ops/bin:/usr/local/src/bin:/usr/local/bin:${PATH}"

# Install jq
COPY --from=jq_installer /usr/bin/jq /usr/local/bin/jq
COPY --from=jq_installer /usr/lib/libonig.so.5 /usr/lib/libonig.so.5

# Install sops
COPY --from=sops_installer "/tmp/sops-*.linux" /usr/local/bin/sops

# Install bash, common certs, python, aws cli & stacker
RUN apk -Uuv add bash ca-certificates python py-pip  \
    && pip install awscli==$AWS_CLI_VERSION          \
    && pip install stacker==$STACKER_VERSION         \
    && apk --purge -v del py-pip                     \
    && rm /var/cache/apk/*

# Where to mount source code for builds
WORKDIR /usr/local/src

CMD /bin/ash
################################################################################
