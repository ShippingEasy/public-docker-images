# serverless-ruby
Docker image for the serverless-ruby image which is used to deploy serverless
ruby projects that may have been generated with Pardner

## Versions

### 1.4.0

| library | version |
|---------|---------|
|ruby     |2.7.3    |
|bundler  |1.17.2   |
|node     |14.x     |
|npm      |6.x      |
|yarn     |1.19.1   |
|aws-cli  |1.16.261 |
|jq       |1.5-1    |
|nc       |7.50     |

### 1.3.0

| library | version |
|---------|---------|
|ruby     |2.7.3    |
|bundler  |1.17.2   |
|node     |12.x     |
|npm      |6.x      |
|yarn     |1.19.1   |
|aws-cli  |1.16.261 |
|jq       |1.5-1    |
|nc       |7.50     |

## Releasing
1. Build the image locally with `docker build -t shippingeasy/serverless-ruby:<version> .`
  1. If you'd like to verify versions in a bash shell, run `docker run -ti --rm shippingeasy/serverless-ruby:<version>`
2. Make sure you are logged in to dockerhub with `docker login`
4. Push the image to dockerhub with `docker push shippingeasy/serverless-ruby:<version>`

## Dependencies

- [Branded Tracking](https://github.com/shipstation/branded-tracking) relies on this image for [Backend CI](https://github.com/shipstation/branded-tracking/blob/shipengine-intg/.build/backend-ci-docker-compose.yaml#L39) and deploys ([frontend](https://github.com/shipstation/branded-tracking/blob/shipengine-intg/.build/frontend_deploy.yaml#L34), [backend](https://github.com/shipstation/branded-tracking/blob/shipengine-intg/.build/backend_deploy.yaml#L38)).
- [Pardner](https://github.com/ShippingEasy/pardner) relies on this image for [CI](https://github.com/ShippingEasy/pardner/blob/master/localstack-ruby/.buildkite/ci-docker-environment.yaml#L13) and [Deploys](https://github.com/ShippingEasy/pardner/blob/master/localstack-ruby/.buildkite/deploy.yaml#L26)
- [PostShip Webhooks](https://github.com/ShippingEasy/postship_webhooks) relies on this image for [CI](https://github.com/ShippingEasy/postship_webhooks/blob/staging/.buildkite/ci-docker-environment.yaml#L13) and [Deploys](https://github.com/shipstation/branded-tracking/blob/shipengine-intg/.build/frontend_deploy.yaml#L34)