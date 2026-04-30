#!/bin/bash
set -e

cd "$(dirname "$0")/.."

# Load .env (handles values with spaces)
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

# Read key contents from file path
if [ -f "$TAURI_SIGNING_PRIVATE_KEY" ]; then
  export TAURI_SIGNING_PRIVATE_KEY="$(cat "$TAURI_SIGNING_PRIVATE_KEY")"
fi

TAURI_CONFIG_OVERRIDE=""
if [ -z "$TAURI_SIGNING_PRIVATE_KEY" ]; then
  TAURI_CONFIG_OVERRIDE='{"bundle":{"createUpdaterArtifacts":false}}'
fi

# Clean previous bundle
rm -rf src-tauri/target/release/bundle

# Build
if [ -n "$TAURI_CONFIG_OVERRIDE" ]; then
  bun tauri build --config "$TAURI_CONFIG_OVERRIDE" "$@"
else
  bun tauri build "$@"
fi

echo ""
echo "✓ Build complete! Output:"
find src-tauri/target/release/bundle \
  \( -name '*.dmg' -o -name '*.app' -o -name '*.deb' -o -name '*.AppImage' \) \
  -print | sort
