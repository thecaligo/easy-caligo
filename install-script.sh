#!/bin/bash

set -e

echo "🚀 Installing easy-caligo..."

INSTALL_DIR="$HOME/.local/bin"
TMP_DIR="$(mktemp -d)"
GH_REPO="https://github.com/thecaligo/easy-caligo"

echo "🔍 Fetching latest version info..."
LATEST_TAG=$(curl -sI "$GH_REPO/releases/latest" | grep -i location | sed -E 's|.*/tag/(.*)\r|\1|')

ZIP_NAME="easy-caligo-${LATEST_TAG}.zip"
ZIP_URL="$GH_REPO/releases/download/${LATEST_TAG}/${ZIP_NAME}"

echo "📦 Downloading $ZIP_NAME..."
curl -sL "$ZIP_URL" -o "$TMP_DIR/$ZIP_NAME"

echo "📂 Extracting..."
unzip -qo "$TMP_DIR/$ZIP_NAME" -d "$TMP_DIR"

echo "📁 Installing to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
mv "$TMP_DIR/easy-caligo" "$INSTALL_DIR/easy-caligo"
chmod +x "$INSTALL_DIR/easy-caligo"

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
  echo "🛠️  Updating PATH in .bashrc..."
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "🧹 Cleaning up..."
rm -rf "$TMP_DIR"

echo "✅ easy-caligo $LATEST_TAG successfully installed!"
echo "🔁 Please restart terminal or run: source ~/.bashrc"
echo "➡️  Then try: easy-caligo"
