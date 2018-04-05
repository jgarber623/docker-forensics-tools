FROM debian:stretch-backports

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  forensics-all \
  forensics-extra && \
  rm -rf /var/lib/apt/lists/*
