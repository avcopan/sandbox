#!/usr/bin/env bash
# Link the sandbox command into ~/.local/bin. Safe to run more than once.

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
BIN="$HOME/.local/bin"

mkdir -p "$BIN"
chmod +x "$REPO/sandbox.sh"
ln -sfn "$REPO/sandbox.sh" "$BIN/sandbox"
echo "Linked $BIN/sandbox -> $REPO/sandbox.sh"

case ":$PATH:" in
    *":$BIN:"*) ;;
    *) echo "Warning: $BIN is not on your PATH." >&2 ;;
esac
