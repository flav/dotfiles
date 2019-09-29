default: link-dotfiles

link-dotfiles:
	sh dotfiles/install.sh

install-homebrew:
	sh osx/install-homebrew.sh

mac: install-homebrew
	sh osx/index.sh
