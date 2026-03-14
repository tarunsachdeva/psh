.PHONY: install uninstall clean test

install:
	@./scripts/install.sh

uninstall:
	@./scripts/uninstall.sh

clean:
	rm -rf .venv
	@echo "Cleaned"

test:
	@bash -n bin/pi-shell
	@bash -n bin/pi-shell-uninstall
	@bash -n scripts/install.sh
	@bash -n scripts/uninstall.sh
	@echo "Syntax OK"
