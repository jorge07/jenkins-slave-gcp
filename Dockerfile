FROM jenkinsci/jnlp-slave:3.7-1

LABEL maintainer="Jorge Arco <jorge.arcoma@gmail.com>"

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH /opt/google-cloud-sdk/bin:$PATH
ENV DOCKER_API_VERSION=1.21
ENV DOCKER_COMPOSE_VERSION 1.12.

USER root

# Install Google Cloud Components
RUN apt update \
    && apt install curl python \
    && curl https://sdk.cloud.google.com | bash \
    && mv google-cloud-sdk /opt \
    && gcloud components install kubectl \
    && curl -fsSL https://get.docker.com/ | sh \
    && curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

