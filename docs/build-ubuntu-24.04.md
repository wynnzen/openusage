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

## Build DEB and AppImage

```bash
cd /home/runner/work/openusage/openusage
bun install
bun run build:ubuntu
```

## Output files

- DEB: `src-tauri/target/release/bundle/deb/*.deb`
- AppImage: `src-tauri/target/release/bundle/appimage/*.AppImage`

## Build executable only

```bash
cd /home/runner/work/openusage/openusage
bun install
bun run bundle:plugins
bun run build
cargo build --manifest-path src-tauri/Cargo.toml --release
./src-tauri/target/release/openusage
```
