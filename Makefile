default: install

dependencies: install-homebrew
	@command -v stow >/dev/null 2>&1 || brew install stow 2>/dev/null || sudo apt-get install -y stow 2>/dev/null || sudo yum install -y stow 2>/dev/null || { echo >&2 "Please install GNU stow"; exit 1; }

install-homebrew:
	sh osx/install-homebrew.sh

submodules:
	git submodule update --init

stowconfig:
	sh stow/index.sh

install: dependencies submodules stowconfig

mac: install
	sh osx/index.sh
