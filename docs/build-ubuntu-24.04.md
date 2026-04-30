# Ubuntu 24.04 build guide

## Install system packages

```bash
sudo apt update
sudo apt install -y \
  build-essential \
  libssl-dev \
  pkg-config \
  libgtk-3-dev \
  libwebkit2gtk-4.1-dev \
  libayatana-appindicator3-dev \
  libxdo-dev \
  patchelf
```

## Install Bun

```bash
npm install -g bun
```

## Build DEB

```bash
cd /home/runner/work/openusage/openusage
bun install
bun run build:ubuntu
```

If `TAURI_SIGNING_PRIVATE_KEY` is not set, the build script disables updater artifacts automatically so local Ubuntu builds still work.

## Output files

- DEB: `src-tauri/target/release/bundle/deb/*.deb`
- Executable: `src-tauri/target/release/openusage`

## Build executable only

```bash
cd /home/runner/work/openusage/openusage
bun install
bun run bundle:plugins
bun run build
cargo build --manifest-path src-tauri/Cargo.toml --release
./src-tauri/target/release/openusage
```
