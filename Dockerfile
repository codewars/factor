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
    mkdir -p /tmp/testest; \
    wget -q -O - https://github.com/codewars/testest/archive/refs/tags/v${TESTEST_VERSION}.tar.gz | tar xz -C /tmp/testest --strip-components=1; \
    cd /tmp/testest; \
    mv tools /opt/factor/work; \
    mv math /opt/factor/work; \
    rm -rf /tmp/testest;

ADD src/imager.factor /tmp/imager.factor

# Install Factor
RUN set -ex; \
    cd /opt; \
    wget -q -O - https://downloads.factorcode.org/releases/${FACTOR_VERSION}/factor-linux-x86-64-${FACTOR_VERSION}.tar.gz | tar xzf -; \
# To minimize the size, remove misc/ (editor support, icons), some of extra/ (extra libs, apps and demos)
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
        ./extra/cuda/gl \
        ./extra/fluids \
        ./extra/game \
        ./extra/gml \
        ./extra/mason/test \
        ./extra/model-viewer \
        ./extra/papier \
        ./extra/taxes/usa/mn \
        ./extra/webapps \
        ./extra/chipmunk/demo \
        ./extra/euler \
        ./extra/gamelib \
        ./extra/opengl \
        ./extra/terrain \
        ./extra/L-system \
        ./extra/boids \
        ./extra/bubble-chamber \
        ./extra/golden-section \
        ./extra/gtk-samples \
        ./extra/jamshred \
        ./extra/math/splines/testing \
        ./extra/math/splines/viewer \
        ./extra/maze \
        ./extra/nehe \
        ./extra/processing \
        ./extra/spheres \
        ./extra/trails \
        ./extra/roms \
    ; \
# reimage factor.image
  ./factor -factor-version="$FACTOR_VERSION" -testest-version="$TESTEST_VERSION" /tmp/imager.factor; \
  rm /tmp/imager.factor;

ENV PATH=/opt/factor:$PATH \
    FACTOR_ROOTS=/workspace

USER codewarrior
WORKDIR /workspace
