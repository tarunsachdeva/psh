#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="${PI_SHELL_TARGET_DIR:-$HOME/.local/bin}"
GHOSTTY_CONFIG="${PI_GHOSTTY_CONFIG:-$HOME/.config/ghostty/config}"

if [ -x "$TARGET_DIR/pi-shell" ]; then
  rm -f "$TARGET_DIR/pi-shell"
  echo "Removed $TARGET_DIR/pi-shell"
fi

if [ -x "$TARGET_DIR/pi-shell-uninstall" ]; then
  rm -f "$TARGET_DIR/pi-shell-uninstall"
  echo "Removed $TARGET_DIR/pi-shell-uninstall"
fi

if [ -f "$GHOSTTY_CONFIG" ]; then
  tmp=$(mktemp)
  awk '!/^command[[:space:]]*=.*pi-shell/' "$GHOSTTY_CONFIG" > "$tmp"
  mv "$tmp" "$GHOSTTY_CONFIG"
  echo "Removed pi-shell command overrides from $GHOSTTY_CONFIG"
fi

echo "Uninstall done."

echo "If you added aliases, remove lines manually from ~/.zshrc (look for: alias psh, alias pshr)."
