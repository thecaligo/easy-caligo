#!/bin/bash

set -e

echo "🚀 Installing easy-caligo..."

INSTALL_DIR="$HOME/.local/bin"
BINARY_URL="https://github.com/thecaligo/easy-caligo/releases/latest/download/easy-caligo"
BINARY_PATH="$INSTALL_DIR/easy-caligo"

mkdir -p "$INSTALL_DIR"

echo "📦 Downloading easy-caligo..."
curl -sL "$BINARY_URL" -o "$BINARY_PATH"

chmod +x "$BINARY_PATH"

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
  echo "🛠️  Updating PATH in .bashrc..."
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "🔁 Reloading shell..."
source "$HOME/.bashrc"

echo "✅ easy-caligo successfully installed!"
echo "Try run: easy-caligo"
