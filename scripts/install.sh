#!/usr/bin/env bash

set -euo pipefail

TARGET_DIR="${PI_SHELL_TARGET_DIR:-$HOME/.local/bin}"
INSTALL_ALIAS="${PI_INSTALL_ALIAS:-1}"
INSTALL_GHOSTTY="${PI_INSTALL_GHOSTTY:-0}"
GHOSTTY_CONFIG="${PI_GHOSTTY_CONFIG:-$HOME/.config/ghostty/config}"
PI_ASSUME_YES_DEFAULT="${PI_ASSUME_YES_DEFAULT:-1}"

mkdir -p "$TARGET_DIR"

cp "$(dirname "$0")/../bin/pi-shell" "$TARGET_DIR/pi-shell"
cp "$(dirname "$0")/../bin/pi-shell-uninstall" "$TARGET_DIR/pi-shell-uninstall"
chmod +x "$TARGET_DIR/pi-shell" "$TARGET_DIR/pi-shell-uninstall"

# Optional alias setup for zsh users
if [ "$INSTALL_ALIAS" = "1" ]; then
  if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "alias psh=" "$HOME/.zshrc"; then
      {
        echo
        echo "# pi-shell alias"
        echo "alias psh='env PI_ASSUME_YES=$PI_ASSUME_YES_DEFAULT $TARGET_DIR/pi-shell'"
        echo "alias pshr='env PI_ASSUME_YES=$PI_ASSUME_YES_DEFAULT PI_AUTO_RAW=1 $TARGET_DIR/pi-shell'"
      } >> "$HOME/.zshrc"
      echo "Added aliases to $HOME/.zshrc"
    else
      echo "Skipping alias insertion; existing alias psh found in $HOME/.zshrc"
    fi
  else
    echo "No ~/.zshrc found; alias not installed"
  fi
fi

# Optional Ghostty command override
if [ "$INSTALL_GHOSTTY" = "1" ]; then
  if [ -f "$GHOSTTY_CONFIG" ]; then
    BACKUP="$GHOSTTY_CONFIG.bak.pi-shell.$(date +%Y%m%d-%H%M%S)"
    cp "$GHOSTTY_CONFIG" "$BACKUP"
    tmp=$(mktemp)
    command_line="command = env PI_ASSUME_YES=$PI_ASSUME_YES_DEFAULT $TARGET_DIR/pi-shell"

    replaced="0"
    while IFS= read -r line; do
      if printf '%s' "$line" | grep -q '^command[[:space:]]*='; then
        echo "$command_line"
        replaced="1"
      else
        echo "$line"
      fi
    done < "$GHOSTTY_CONFIG" > "$tmp"

    if [ "$replaced" = "0" ]; then
      echo "$command_line" >> "$tmp"
    fi

    mv "$tmp" "$GHOSTTY_CONFIG"
    echo "Updated Ghostty config. Backup: $BACKUP"
  else
    mkdir -p "$(dirname "$GHOSTTY_CONFIG")"
    echo "command = env PI_ASSUME_YES=$PI_ASSUME_YES_DEFAULT $TARGET_DIR/pi-shell" > "$GHOSTTY_CONFIG"
    echo "Created Ghostty config: $GHOSTTY_CONFIG"
  fi
fi

echo "Installed pi-shell to: $TARGET_DIR"
echo "Run: psh (or source ~/.zshrc)"
