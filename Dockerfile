ARG ALPINE_VERSION

FROM python:3.11-alpine${ALPINE_VERSION} as builder

ARG AWS_CLI_VERSION
ARG REF_TYPE=tags

RUN apk add --update-cache --no-cache \
        unzip \
        groff \
        build-base \
        libffi-dev \
        cmake

WORKDIR /aws-cli

RUN wget https://github.com/aws/aws-cli/archive/refs/${REF_TYPE}/${AWS_CLI_VERSION}.tar.gz -qO- | \
  tar -xz --strip-components=1 --exclude=.changes --exclude=.github --exclude=tests --exclude=proposals

RUN python -m venv venv
RUN . venv/bin/activate
RUN scripts/installers/make-exe
RUN unzip -q dist/awscli-exe.zip
RUN aws/install --bin-dir /aws-cli-bin
RUN /aws-cli-bin/aws --version

# reduce image size: remove autocomplete and examples
RUN rm -rf /usr/local/aws-cli/v2/current/dist/aws_completer /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index /usr/local/aws-cli/v2/current/dist/awscli/examples
RUN find /usr/local/aws-cli/v2/current/dist/awscli/data -name completions-1*.json -delete
RUN find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete

FROM alpine:${ALPINE_VERSION}
LABEL maintainer="theidledeveloper@gmail.com"

COPY --from=builder /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=builder /aws-cli-bin/ /usr/local/bin/
