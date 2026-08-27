#!/usr/bin/env bash
# Open a disposable container shell in the current directory.

set -euo pipefail

# Resolve through the ~/.local/bin symlink to find the repo.
REPO="$(dirname "$(readlink -f "$0")")"

# Built once on first use; every project reuses the same image.
if ! podman image exists sandbox; then
    podman build -t sandbox - <"$REPO/Containerfile"
fi

podman run --rm -it \
    -v "$PWD":/workspace:Z \
    -v claude-config:/root/.claude \
    sandbox
