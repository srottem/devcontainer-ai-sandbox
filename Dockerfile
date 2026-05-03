FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    curl wget git ca-certificates \
    python3 python3-pip \
    nodejs npm \
    composer \
    podman \
    && rm -rf /var/lib/apt/lists/*

# Non-root user for everything (including Podman)
RUN useradd -ms /bin/bash coder
USER coder
WORKDIR /home/coder

# Rootless Podman setup (per-user storage)
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV PODMAN_USERNS=keep-id
RUN mkdir -p ${XDG_RUNTIME_DIR} && \
    chmod 700 ${XDG_RUNTIME_DIR}

# Workspace
RUN mkdir -p /home/coder/workspace
WORKDIR /home/coder/workspace

# Claude CLI
RUN curl -fsSL https://install.anthropic.com | sh

# OpenCode
RUN npm install -g opencode

CMD ["/bin/bash"]
