# pi-shell

A small natural-language shell wrapper powered by `pi`.

- Type plain language and it translates to bash via `pi -p`.
- Optionally bypass translation with `/raw <command>`.
- Built-in safety + optional confirmation flow.
- Optional Ghostty integration.

## Included scripts

- `bin/pi-shell` — main shell wrapper
- `bin/pi-shell-uninstall` — removes global install + Ghostty override (if present)
- `scripts/install.sh` — installs scripts into `~/.local/bin` and optionally configures aliases/Ghostty
- `scripts/uninstall.sh` — removes installed files and Ghostty override

## Quick install

```bash
cd ~/code/pi-shell-repl
./scripts/install.sh
```

Then open a new shell and run:

```bash
source ~/.zshrc
psh
```

## Install env toggles

- `PI_ASSUME_YES_DEFAULT` (default: `1`) — sets default confirmation mode for the shell command.
- `PI_INSTALL_ALIAS` (default: `1`) — add alias lines to `~/.zshrc`.
- `PI_INSTALL_GHOSTTY` (default: `0`) — update `~/.config/ghostty/config`.

Example:

```bash
PI_INSTALL_GHOSTTY=1 PI_ASSUME_YES_DEFAULT=0 ./scripts/install.sh
```

## Aliases added by installer

- `psh` → `env PI_ASSUME_YES=<default> <install-dir>/pi-shell`
- `pshr` → `env PI_ASSUME_YES=<default> PI_AUTO_RAW=1 <install-dir>/pi-shell`

(`PI_AUTO_RAW` is included for extension usage in future; current `pi-shell` behavior currently supports `/raw` command-line usage.)

## Runtime commands inside pi-shell

- `/help`
- `/raw <command>`
- `/auto on|off`
- `/noconfirm on|off`
- `/show on|off`
- `/quit`

## Optional manual Ghostty config

Set in `~/.config/ghostty/config`:

```ini
command = env PI_ASSUME_YES=1 /Users/you/.local/bin/pi-shell
```

## Uninstall

If installed through scripts:

```bash
./scripts/uninstall.sh
```

Or run `~/.local/bin/pi-shell-uninstall` if using previous one-off setup.
