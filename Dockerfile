FROM ubuntu:18.04

ENV FACTOR_VERSION=0.99 TESTEST_VERSION=2.1
ENV LANG=C.UTF-8

RUN set -ex; \
    useradd --create-home codewarrior; \
    mkdir -p /workspace; \
    chown -R codewarrior:codewarrior /workspace;

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        libssl-dev \
        libsqlite3-dev \
        zlib1g-dev \
        libpq-dev \
        libsnappy-dev \
        libzstd-dev \
    ; \
    rm -rf /var/lib/apt/lists/*;

# Add the test framework
RUN set -ex; \
    mkdir -p /opt/factor/work; \
    mkdir -p /opt/factor/pre; \
    mkdir -p /tmp/testest; \
    wget -q -O - https://github.com/codewars/testest/archive/refs/tags/v${TESTEST_VERSION}.tar.gz | tar xz -C /tmp/testest --strip-components=1; \
    cd /tmp/testest; \
    mv tools /opt/factor/work; \
    mv codewars /opt/factor/work; \
    mv math /opt/factor/pre; \
    rm -rf /tmp/testest;

# Install Factor
RUN set -ex; \
    cd /opt; \
    wget -q -O - https://downloads.factorcode.org/releases/${FACTOR_VERSION}/factor-linux-x86-64-${FACTOR_VERSION}.tar.gz | tar xzf -; \
# To minimize the size, remove misc/ (editor support, icons), some of extra/ (extra libs and apps)
    cd /opt/factor; \
    rm -rf \
        ./misc \
        ./extra/bunny \
        ./extra/images/testing \
        ./extra/usa-cities \
        ./extra/clutter \
        ./extra/gstreamer \
        ./extra/websites \
        ./extra/benchmark \
        ./extra/gpu \
        ./extra/snake-game \
        ./extra/project-euler \
        ./extra/rosetta-code \
        ./extra/audio/engine/test \
        ./extra/talks \
    ; \
# reimage factor.image
    ./factor -factor-version="$FACTOR_VERSION" -testest-version="$TESTEST_VERSION" -run=codewars.imager;

ENV PATH=/opt/factor:$PATH \
    FACTOR_ROOTS=/workspace

USER codewarrior
WORKDIR /workspace
