FROM debian:stretch-slim

# Install dependencies
RUN mkdir /usr/share/man/man1 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      default-jre \
      forensics-all \
      forensics-extra && \
    rm -rf /var/lib/apt/lists/*

# Post-installation cleanup
RUN apt-get autoclean -y && \
    rm -rf /tmp/* /var/tmp/*

# Set default working directory
WORKDIR /workspace
