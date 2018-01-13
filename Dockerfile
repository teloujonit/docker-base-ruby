FROM ruby:2.5-alpine3.7

LABEL maintainer="Louis Taylor <lt@teloujon.com>"

# s6 overlay version
ARG OVERLAY_VERSION="v1.21.2.2"
ARG OVERLAY_ARCH="amd64"

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)$ " \
HOME="/root" \
TERM="xterm"

# root filesystem
COPY rootfs /

# s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-${OVERLAY_ARCH}.tar.gz -C / && \
  echo "### ADD BASE FOLDERS ###" && \
  mkdir -p /app /config /defaults && \
  echo "### CLEANUP ###" && \
  rm -rf /tmp/*

# init
ENTRYPOINT ["/init"]
