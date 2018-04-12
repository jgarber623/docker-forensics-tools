FROM debian:stretch-slim

# Install dependencies
RUN mkdir /usr/share/man/man1 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      ant \
      autoconf \
      bison \
      clang \
      coreutils \
      expect \
      findutils \
      flex \
      git \
      libboost1.62-dev \
      libbz2-dev \
      libewf-dev \
      libicu-dev \
      libicu57 \
      libncurses5-dev \
      libsqlite3-0 \
      libsqlite3-dev \
      libssl-dev \
      libssl1.0.2 \
      libtool \
      libtre-dev \
      libtre5 \
      libxml2 \
      libxml2-dev \
      make \
      openjdk-8-jdk \
      pkg-config \
      rsync \
      sqlite3 \
      tar \
      wget \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install liblightgrep and bulk_extractor
WORKDIR /tmp

RUN git clone --depth 1 --recursive https://github.com/jonstewart/liblightgrep && \
    cd liblightgrep && \
    ./bootstrap.sh && \
    ./configure --with-boost-chrono=no --with-boost-thread=no --with-boost-program-options=no --with-boost-system=no --prefix=/usr && \
    make -j 8 && \
    make install && \
    ldconfig && \
    rm -rf /tmp/liblightgrep

RUN git clone --depth 1 --recursive https://github.com/simsong/bulk_extractor && \
    cd bulk_extractor && \
    chmod 755 bootstrap.sh && \
    ./bootstrap.sh && \
    ./configure --enable-lightgrep --prefix=/usr/local && \
    make -j 8 && \
    make install && \
    rm -rf /tmp/bulk_extractor

# Post-installation cleanup
RUN apt-get autoclean -y && \
    rm -rf /tmp/* /var/tmp/*

# Set default working directory
WORKDIR /workspace
