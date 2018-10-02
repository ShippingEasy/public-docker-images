# aws-cli-builder
Docker image that provides common tools and structure for builds
where the following is needed:

* `bash` command: for scripting
* [`sops` command](https://github.com/mozilla/sops): for decrypting secrets
* [`jq` command](https://stedolan.github.io/jq/manual/): for parsing aws
  responses
* [`aws` command](https://docs.aws.amazon.com/cli/latest/reference/): for
  interacting with AWS services and resources
* [`stacker` command](https://github.com/cloudtools/stacker) for managing
  cloudformation stacks

It also encourages the following:

* source code for the build should be copied/mounted to `/usr/local/src`
* executables for the build should be placed in the following locations:
  * `/usr/local/src/bin`
  * `/usr/local/src/ops/bin`

## Versions
| command   | version |
|-----------|---------|
| `bash`    | 4.4.19  |
| `aws`     | 1.15.85 |
| `jq`      | 1.6     |
| `sops`    | 3.1.1   |
| `stacker` | 1.4.1   |

## Usage
This image is built upon Alpine to keep size small.  By default, when run
with the following command you will have a terminal running the `ash`
shell in the `/usr/local/src` directory.

```
docker run -ti shippingeasy/aws-cli-builder
```

This image can be built upon to install other dependencies for build tasks,
such as the language runtime needed to execute tests, etc...

To use the `aws` command from within the container, it will need to find
credentials to use.  There are three ways to do this:

* Specify your credentials explicitly
  * Use the `--env` flag to specify the `AWS_ACCESS_KEY_ID` and
    `AWS_SECRET_ACCESS_KEY` to use for credentials in the container
* Specify the credentials of an assumed role
  * Use `aws sts assume-role` to get an `Credentials.AccessKeyId`,
    `Credentials.SecretAccessKey` and `Credentials.SessionToken` values
  * Use the above values to specify the `AWS_ACCESS_KEY_ID`,
    `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN` environment variables
    for the container using the `--env` flag
* Mount your `~/.aws` directory to `/root/.aws` if using aws cli profiles
  * Don't expect this to work in build/ci environments where your credentials
    stored in `~/.aws` will not be available.

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
1. Make a build with `docker build -t shippingeasy/aws-cli-builder .`
  1. Use `--build-arg` to specify new values for `JQ_VERSION`, `SOPS_VERSION` or
     `AWS_CLI_VERSION`
2. Make sure you are logged in to dockerhub with `docker login`
3. Tag the docker image `docker tag <image-id> shippingeasy/aws-cli-builder:X.Y.Z`
4. Push the image to dockerhub with `docker push shippingeasy/aws-cli-builder:X.Y.Z`
