default: link-dotfiles

link-dotfiles:
	dotfiles/install.sh

install-homebrew:
	osx/install-homebrew.sh

mac: install-homebrew
	osx/index.sh
