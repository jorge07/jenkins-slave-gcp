FROM jenkinsci/jnlp-slave:3.7-1

LABEL maintainer="Jorge Arco <jorge.arcoma@gmail.com>"

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH /opt/google-cloud-sdk/bin:$PATH
ENV DOCKER_API_VERSION=1.21
ENV DOCKER_COMPOSE_VERSION 1.12.0

USER root

# Install Google Cloud Components
RUN apt update \
    && apt install -y apt-transport-https \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt update \
    && apt install -y apt-transport-https ant curl python nodejs gettext-base yarn npm \
    && curl https://sdk.cloud.google.com | bash \
    && mv google-cloud-sdk /opt \
    && gcloud components install kubectl \
    && curl -fsSL https://get.docker.com/ | sh \
    && curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

