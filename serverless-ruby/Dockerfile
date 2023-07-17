################################################################
# Dockerfile to create the serverless-ruby image which
# is to be used to deploy serverless ruby projects generated
# with pardner.
#
# Provides:
#
#    ruby          2.7.3
#    bundler      1.17.2
#    node           14.x
#    npm             6.x
#    yarn         1.19.1
#    aws-cli    1.16.261
#    jq            1.5-1
#    nc             7.50
#
# Current Image Version w/above deps
#
#   1.4.0
#
# To build image, from the serverless-ruby directory run:
#
#    docker build -t shippingeasy/serverless-ruby:<version> .
#
# To launch container:
#
#    docker run -ti --rm shippingeasy/serverless-ruby:<version>
#
# To push image to dockerhub:
#
#    docker push shippingeasy/serverless-ruby:<version>
#
################################################################################
FROM lambci/lambda:build-ruby2.7

RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -                                         \
 && curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo                  \
 && yum install -y nodejs yarn                                                                      \
 && curl -sL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 > /usr/local/bin/jq \
 && chmod +x /usr/local/bin/jq                                                                      \
 && npm install -g serverless                                                                       \
 && yum install -y nc                                                                               \
 && yum clean all

ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH

CMD '/bin/bash'
