FROM ghcr.io/prefix-dev/pixi:latest

# Add curl, cleaning up package indexes afterwards
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl git vim ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Add ~/.local/bin to path
ENV PATH=/root/.local/bin:$PATH

# Install claude
RUN curl -fsSL https://claude.ai/install.sh | bash

WORKDIR /workspace
ENTRYPOINT ["/bin/bash"]
