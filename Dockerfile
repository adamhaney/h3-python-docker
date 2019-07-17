# AUTHOR: Adam Haney @adamhaney
# DESCRIPTION: Docker image that installs dependencies of H3: Uber’s Hexagonal Hierarchical Spatial Index for using the python library
# SOURCE: https://github.com/eat-on-the-house/h3-python-docker

ARG PYTHON_VERSION=3.6
ARG BUILD_PACKAGES="gcc make cmake curl build-essential apt-utils cmake-curses-gui git unzip doxygen"
ARG H3_LIB_HASH="af70aff"

FROM python:$PYTHON_VERSION-slim-stretch

# H3 Depdendencies
RUN apt-get update && \
    apt-get install -yqq wget $BUILD_PACKAGES libffi-dev libgdal-dev zlib1g-dev libgeos-dev libtool clang-format && \
    wget "https://github.com/uber/h3/archive/$H3_LIB_HASH.zip" && \
    unzip $H3_LIB_HASH.zip && \
    cd h3-af70affba76c64adbb836ee1864f5a4b495f0f6a && \
    cmake . && \
    make && \
    make install && \
    pip install h3 && \
    cd .. && rm -rf h3-af70affba76c64adbb836ee1864f5a4b495f0f6a

 RUN apt-get -y remove ${BUILD_PACKAGES}
