FROM debian:stretch-backports

# Install dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ant \
      autoconf \
      automake \
      bison \
      build-essential \
      clang \
      cmake \
      coreutils \
      expect \
      findutils \
      flex \
      forensics-all \
      forensics-extra \
      git \
      libatlas-base-dev \
      libboost-all-dev \
      libboost1.62-dev \
      libbz2-dev \
      libewf-dev \
      libgflags-dev \
      libgoogle-glog-dev \
      libhdf5-serial-dev \
      libicu-dev \
      libicu57 \
      libleveldb-dev \
      liblmdb-dev \
      libncurses5-dev \
      libopencv-dev \
      libprotobuf-dev \
      libsnappy-dev \
      libsqlite3-0 \
      libsqlite3-dev \
      libssl-dev \
      libssl1.0.2 \
      libtool \
      libtool-bin \
      libtre-dev \
      libtre5 \
      libxml2 \
      libxml2-dev \
      make \
      openjdk-8-jdk \
      pkg-config \
      protobuf-compiler \
      python-dev \
      python-numpy \
      python-pip \
      python-scipy \
      python-setuptools \
      rsync \
      sqlite3 \
      swig \
      tar \
      wget \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install and configure bulk_extractor with lightgrep
WORKDIR /tmp

RUN git clone --depth 1 --recursive https://github.com/jonstewart/liblightgrep && \
    cd liblightgrep && \
    ./bootstrap.sh && \
    ./configure --with-boost-chrono=no --with-boost-thread=no --with-boost-program-options=no --with-boost-system=no --prefix=/usr && \
    make -j "$(nproc)" && \
    make install && \
    ldconfig && \
    rm -rf /tmp/liblightgrep

RUN git clone --depth 1 --recursive https://github.com/simsong/bulk_extractor && \
    cd bulk_extractor && \
    chmod 755 bootstrap.sh && \
    ./bootstrap.sh && \
    ./configure --enable-lightgrep --prefix=/usr/local && \
    make -j "$(nproc)" && \
    make install && \
    rm -rf /tmp/bulk_extractor

# Install and configure Caffe
ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

RUN git clone -b 1.0 --depth 1 https://github.com/BVLC/caffe . && \
    pip install --upgrade pip && \
    pip install -r python/requirements.txt && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 .. && \
    make -j "$(nproc)"

ENV PYCAFFE_ROOT=$CAFFE_ROOT/python \
    PYTHONPATH=$PYCAFFE_ROOT:$PYTHONPATH \
    PATH=$CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH

RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# Install and configure open_nsfw
ENV OPEN_NSFW_ROOT=/opt/open_nsfw
WORKDIR $OPEN_NSFW_ROOT

RUN git clone --depth 1 https://github.com/yahoo/open_nsfw . && \
    chmod +x classify_nsfw.py

ENV OPEN_NSFW_MODEL_ROOT=$OPEN_NSFW_ROOT/nsfw_model \
    PYOPEN_NSFW_ROOT=$OPEN_NSFW_ROOT \
    PYTHONPATH=$OPEN_NSFW_ROOT:$PYTHONPATH \
    PATH=$OPEN_NSFW_ROOT:$PATH

# Post-installation cleanup
RUN apt-get remove -y \
      ant \
      autoconf \
      automake \
      autotools-dev \
      bison \
      build-essential \
      clang \
      cmake \
      g++ \
      g++-6 \
      gcc \
      gcc-6 \
      libatlas-base-dev \
      libboost-all-dev \
      libboost1.62-dev \
      libbz2-dev \
      libc6-dev \
      libclang-common-3.8-dev \
      libclang-common-3.9-dev \
      libclc-dev \
      libewf-dev \
      libgcc-6-dev \
      libgflags-dev \
      libgoogle-glog-dev \
      libhdf5-serial-dev \
      libicu-dev \
      libleveldb-dev \
      liblmdb-dev \
      libltdl-dev \
      libncurses5-dev \
      libobjc-6-dev \
      libopencv-dev \
      libprotobuf-dev \
      libsmdev1 \
      libsnappy-dev \
      libsqlite3-dev \
      libssl-dev \
      libstdc++-6-dev \
      libtre-dev \
      libxml2-dev \
      linux-libc-dev \
      make \
      openjdk-8-jdk \
      pkg-config \
      python-dev \
      zlib1g-dev && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /tmp/* /var/tmp/*

# Set default working directory
WORKDIR /workspace
