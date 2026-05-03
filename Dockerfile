FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    curl wget git ca-certificates \
    python3 python3-pip \
    nodejs npm \
    composer \
    podman \
    gpg \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -ms /bin/bash coder

# Rootless Podman setup (must be done as root)
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV PODMAN_USERNS=keep-id
RUN mkdir -p ${XDG_RUNTIME_DIR} && \
    chown coder:coder ${XDG_RUNTIME_DIR} && \
    chmod 700 ${XDG_RUNTIME_DIR}

# Switch to non-root user
USER coder
WORKDIR /home/coder

# Workspace
RUN mkdir -p /home/coder/workspace
WORKDIR /home/coder/workspace

# Install Claude CLI
RUN curl -fsSL https://install.anthropic.com | sh

# Install OpenCode (standalone binary)
RUN curl -L https://github.com/OpenCodeAI/opencode/releases/latest/download/opencode-linux-amd64 \
      -o /usr/local/bin/opencode && \
    chmod +x /usr/local/bin/opencode

CMD ["/bin/bash"]
