# psh

A small natural-language shell wrapper powered by `pi`.

- Type plain language and it translates to bash via `pi --session` so the model has one continuous translation session by default.
- Optionally bypass translation with `// <command>`.
- Built-in safety + optional confirmation flow.
- Optional Ghostty integration.

## Included scripts

- `bin/pi-shell` — main shell wrapper
- `bin/pi-shell-uninstall` — removes global install + Ghostty override (if present)
- `scripts/install.sh` — installs scripts into `~/.local/bin` and optionally configures aliases/Ghostty
- `scripts/uninstall.sh` — removes installed files and Ghostty override

## Quick install

```bash
cd ~/code/psh
./scripts/install.sh
```

Then open a new shell and run:

```bash
source ~/.zshrc
psh
```

## Install env toggles

- `PI_ASSUME_YES_DEFAULT` (default: `1`) — sets default confirmation mode for the shell command.
- `PI_CONTINUOUS_SESSION` (default: `1`) — keep a shared Pi session for continuous translation context.
- `PI_SESSION_FILE` (default: `$HOME/.psh-session.jsonl`) — session file path used when `PI_CONTINUOUS_SESSION=1`.
- `PI_INSTALL_ALIAS` (default: `1`) — add alias lines to `~/.zshrc`.
- `PI_INSTALL_GHOSTTY` (default: `0`) — update `~/.config/ghostty/config`.

Example:

```bash
PI_INSTALL_GHOSTTY=1 PI_ASSUME_YES_DEFAULT=0 ./scripts/install.sh
```

## Aliases added by installer

- `psh` → `env PI_ASSUME_YES=<default> PI_CONTINUOUS_SESSION=<default> <install-dir>/pi-shell`
- `pshr` → `env PI_ASSUME_YES=<default> PI_AUTO_RAW=1 PI_CONTINUOUS_SESSION=<default> <install-dir>/pi-shell`
- `PI_AUTO_RAW=1` mode runs every non-slash input directly (no translation), equivalent to a raw passthrough shell.

## Runtime commands inside psh

- `/help`
- `// <command>` (only raw command syntax)
- `/auto on|off`
- `/noconfirm on|off`
- `/show on|off`
- `/quit`

Tip: to disable shared conversation (pure one-shot mode), run `env PI_CONTINUOUS_SESSION=0 psh`.

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

## Git setup

If you want this as a standalone repo to track changes:

```bash
cd ~/code
mkdir -p psh
# replace with your remote URL
# git init is already done; just add your remote and push

git -C psh init

git -C psh remote add origin git@github.com:<your-org-or-user>/psh.git

git -C psh add .
git -C psh commit -m "chore: initialize repository"
git -C psh branch -M main
git -C psh push -u origin main
```

### Current git status quick check

```bash
git -C ~/code/psh status --short
git -C ~/code/psh log --oneline -n 5
```

## Makefile tasks

```bash
cd ~/code/psh

# Install scripts
target=install  # (invokes ./scripts/install.sh)
make install

# Remove installed files and Ghostty config override
make uninstall

# Syntax sanity checks
make test

# Clean workspace
make clean
```

## Package metadata

This repo also includes:
- `package.json` for JS tooling and metadata
- `VERSION` file for release tagging

You can install dependencies and run syntax checks with:

```bash
npm test
```

## Suggested release workflow

```bash
git -C ~/code/psh add .
git -C ~/code/psh commit -m "chore: release"
git -C ~/code/psh tag v0.1.0
git -C ~/code/psh push --tags
```

## Docs notes

- `psh` accepts `PI_*` environment variables for behavior.
- `PI_AUTO_RAW=1` makes every non-slash input run directly.
- Use `// <command>` for one-off passthrough.
- `PI_ASSUME_YES` skips runtime confirmation prompts.
