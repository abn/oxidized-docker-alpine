FROM alpine:latest
MAINTAINER Arun Neelicattu <arun.neelicattu@gmail.com>

ARG OXIDISED_VERSION=0.29.1
ARG OXIDISED_WEB_VERSION=0.13.0

RUN apk --no-cache add --virtual oxidized-runtime \
        ruby git libssh2 sqlite-libs libressl \
    && apk --no-cache add --virtual oxidized-build-deps icu-dev \
        ruby-dev cmake make libssh2-dev g++ sqlite-dev libressl-dev \
    && gem install \
         --no-document \
        json aws-sdk slack-api \
        oxidized:${OXIDISED_VERSION} oxidized-web:${OXIDISED_WEB_VERSION} \
    && apk --no-cache del oxidized-build-deps

RUN mkdir -p /root/.config /etc/oxidized /var/run/oxidized /var/lib/oxidized \
    && ln -sf /etc/oxidized /root/.config/oxidized

VOLUME ["/etc/oxidized", "/var/run/oxidized", "/var/lib/oxidized"]

EXPOSE 8888/tcp

ENTRYPOINT ["/usr/bin/oxidized"]
