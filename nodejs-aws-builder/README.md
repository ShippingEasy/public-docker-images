# nodejs-aws-builder
Docker image that provides common tools and structure for builds where the
following is needed:

* `bash`: for scripting
* [`sops` command](https://github.com/mozilla/sops): for decrypting secrets
* [`jq` command](https://stedolan.github.io/jq/manual/): for parsing aws
  responses
* [`aws` command](https://docs.aws.amazon.com/cli/latest/reference/): for
  interacting with AWS services and resources
* [`stacker` command](https://github.com/cloudtools/stacker) for managing
  cloudformation stacks
* [`node` command](): for running, testing, packaging, building, etc... nodejs
  apps

## Versions
| command   | version |
|-----------|---------|
| `bash`    | 4.4.19  |
| `aws`     | 1.15.85 |
| `jq`      | 1.6     |
| `sops`    | 3.1.1   |
| `stacker` | 1.4.1   |
| `node`    | 8.11.4  |

## Testing the Image
This assumes you have installed and set up
[`aws-vault`](https://github.com/99designs/aws-vault) to manage credentials.

First, build the docker-compose test service:

```
docker-compose build tests
```

Next, run the tests:

```
aws-vault exec <profile> -- docker-compose run tests
```

## Releasing
1. Make a build with `docker build -t shippingeasy/nodejs-aws-builder .`
  1. Use `--build-arg` to specify new values for `JQ_VERSION`, `SOPS_VERSION` or
     `AWS_CLI_VERSION`
2. Make sure you are logged in to dockerhub with `docker login`
3. Tag the docker image `docker tag <image-id> shippingeasy/nodejs-aws-builder:X.Y.Z`
4. Push the image to dockerhub with `docker push shippingeasy/nodejs-aws-builder:X.Y.Z`
