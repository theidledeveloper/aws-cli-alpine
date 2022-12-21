# aws-cli-alpine

##### Docker

![Docker Pulls](https://img.shields.io/docker/pulls/theidledeveloper/aws-cli-alpine)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/theidledeveloper/aws-cli-alpine)
![Docker Stars](https://img.shields.io/docker/stars/theidledeveloper/aws-cli-alpine)

##### Repository

![Latest tag](https://img.shields.io/github/v/tag/theidledeveloper/aws-cli-alpine?label=Latest%20Tag) ![License](https://img.shields.io/github/license/theidledeveloper/aws-cli-alpine)

##### Build Status

![Release Check Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/check_new_release.yml?label=Release%20Check%20Build)

![Latest 3.15 Image Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/build_image_315.yml?label=Latest%203.15%20Image%20Build)
![Latest 3.16 Image Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/build_image_316.yml?label=Latest%203.16%20Image%20Build)
![Latest 3.17 Image Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/build_image_317.yml?label=Latest%203.17%20Image%20Build)

![Nightly 3.15 Image Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/build_image_315_nightly.yml?label=Nightly%203.15%20Image%20Build)
![Nightly 3.16 Image Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/build_image_316_nightly.yml?label=Nightly%203.16%20Image%20Build)
![Nightly 3.17 Image Build](https://img.shields.io/github/actions/workflow/status/theidledeveloper/aws-cli-alpine/build_image_317_nightly.yml?label=Nightly%203.17%20Image%20Build)

A minimal alpine linux container with the aws cli using the tag source from
[aws/aws-cli](https://github.com/aws/aws-cli).

[aws-cli configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

### Build Locally

The image makes use of *ARG* instructions to allow the use of a single [Dockerfile](./Dockerfile) but build images with
different base image versions of aws-cli tags. To properly supply the image ARGs pass in `ALPINE_VERSION` and
`AWS_CLI_VERSION` using the `--build-arg` flag. Alpine image versions can be found at
[alpine dockerhub](https://hub.docker.com/_/alpine) but also need to be cross checked with
[python alpine](https://hub.docker.com/_/python) as this image is used to build the aws-cli from source. You can also
find the available aws-cli tags [here](https://github.com/aws/aws-cli/tags).

To build an alpine *3.17* aws-cli version *2.9.8* use below:

```bash
docker build --build-arg ALPINE_VERSION=3.17 --build-arg AWS_CLI_VERSION=2.9.8 -t aws-cli-alpine:2.9.8 .
```

### Information

Inspired by [devopscorner/aws-cli](https://hub.docker.com/r/devopscorner/aws-cli)
