# AI Sandbox Dev Environment (Ubuntu 26.04 + Claude CLI + OpenCode + Podman)

This repository defines a reusable AI coding sandbox:

- Ubuntu 26.04
- Claude CLI
- OpenCode
- Rootless Podman (for databases, Redis, etc. inside the sandbox)
- Non-root user (`coder`)
- Light hardening (seccomp, no-new-privileges, cap-drop)
- Usable from:
  - VS Code Dev Containers
  - Any IDE via Docker (Eclipse, IntelliJ, CLI)
  - GHCR-published image

---

## 1. One-time setup: create and push the GitHub repo

1. Create a new repo on GitHub, e.g.:

   `https://github.com/<you>/devcontainer-ai-sandbox`

2. On your machine:

   ```bash
   git clone https://github.com/<you>/devcontainer-ai-sandbox.git
   cd devcontainer-ai-sandbox
   # Extract the contents of this template here
   # (Dockerfile, .devcontainer, docker-compose.yml, etc.)
   git add .
   git commit -m "Initial AI sandbox template"
   git push origin main
