# public-docker-images
Dockerfiles for images we are releasing publicly to dockerhub

* [aws-cli-builder](aws-cli-builder/): image providing common tools
  and structure for using the `aws` cli command, `jq` for parsing, `sops` for
  secrets decryption, and others
* [nodejs-aws-builder](nodejs-aws-builder/): image providing a nodejs runtime
  on top of all the goodness of the `aws-cli-builder`
