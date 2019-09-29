FROM debian:latest

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

RUN set -ex; \
    apt-get update -yqq \
    && apt install -qqy \
    cmake \
    gcc \
    g++ \
    libncurses5-dev \
    libreadline-dev \
    libssl-dev \
    make \
    zlib1g-dev \
    git

COPY . .

RUN set -ex; \
    git submodule init \
    && git submodule update \
    && ./configure \
    && make -C tmp \
    && make -C tmp install

# Clean up
#&& rm -rf /tmp/* /var/tmp/* \
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    && rm /var/log/lastlog /var/log/faillog


CMD ["tail", "-f", "/dev/null"]
