FROM debian:stretch-backports

# Install dependencies
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    forensics-all \
    forensics-extra \
    git \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python-dev \
    python-numpy \
    python-pip \
    python-scipy \
    python-setuptools \
    wget && \
  rm -rf /var/lib/apt/lists/*

# Install and configure Caffe
ENV CAFFE_ROOT /opt/caffe
WORKDIR $CAFFE_ROOT

ENV CLONE_TAG 1.0

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe . && \
  pip install --upgrade pip && \
  cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
  mkdir build && cd build && \
  cmake -DCPU_ONLY=1 .. && \
  make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH

RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# Install and configure open_nsfw
ENV OPEN_NSFW_ROOT /opt/open_nsfw
WORKDIR $OPEN_NSFW_ROOT

RUN git clone --depth 1 https://github.com/yahoo/open_nsfw . && \
  chmod +x classify_nsfw.py

ENV OPEN_NSFW_MODEL_ROOT $OPEN_NSFW_ROOT/nsfw_model
ENV PYOPEN_NSFW_ROOT $OPEN_NSFW_ROOT
ENV PYTHONPATH $OPEN_NSFW_ROOT:$PYTHONPATH
ENV PATH $OPEN_NSFW_ROOT:$PATH

# Set default working directory
WORKDIR /workspace
