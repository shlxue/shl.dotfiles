default: init

export DOTFILES_DEBUG=1

.PHONY: prune init install

init:
	./install.sh

install:

prune:
