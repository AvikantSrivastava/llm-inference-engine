FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    # Build utils
    make \
    gcc \
    cmake \
    ninja-build \
    lld \
    clang \
    libcurl4 \
    glslc \

    # AMD GPU drivers and Vulkan SDK utils
    mesa-vulkan-drivers \
    radeontop


# Common utils
RUN apt-get install -y \
    tar \
    gzip \
    curl \
    git \
    vim


# Install amd vulkan drivers
RUN curl -L -o /tmp/amdvlk_2025.Q2.1_amd64.deb \
    https://github.com/GPUOpen-Drivers/AMDVLK/releases/download/v-2025.Q2.1/amdvlk_2025.Q2.1_amd64.deb \
    && apt install -y /tmp/amdvlk_2025.Q2.1_amd64.deb \
    && rm -f /tmp/amdvlk-*.deb

# Install llama.cpp
RUN mkdir -p /opt/llama \
    && curl -L -o /tmp/llama.tar.gz \
        https://github.com/ggml-org/llama.cpp/releases/download/b7735/llama-b7735-bin-ubuntu-vulkan-x64.tar.gz \
    && tar xf /tmp/llama.tar.gz -C /opt/llama \
    && mv /opt/llama/llama*/* /opt/llama/ \
    && rmdir /opt/llama/llama-b7735 \
    && rm -f /tmp/llama-b7735-bin-ubuntu-vulkan-*.tar.gz

RUN ln -s /opt/llama/llama-* /usr/local/bin/
ENTRYPOINT ["llama-server"]
