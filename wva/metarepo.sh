#!/usr/bin/env bash
META_REPO_DIR=$HOME/.cfg

function config {
	/usr/bin/git --git-dir=$META_REPO_DIR --work-tree=$HOME $@
}

if [ ! -d $META_REPO_DIR ]; then
	git clone --bare git@github.com:filipewvandrade/dotfiles.git $HOME/.cfg
fi
config config --local status.showUntrackedFiles no
config reset --hard origin/main
config checkout
config status

