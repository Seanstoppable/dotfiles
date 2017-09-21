#!/bin/sh

mkdir -p ~/bin

ln -sf ~/.dotfiles/irbrc ~/.irbrc
ln -sf ~/.dotfiles/psqlrc ~/.psqlrc
ln -sf ~/.dotfiles/vim ~/.vim
ln -sf ~/.dotfiles/vimrc ~/.vimrc
ln -sf ~/.dotfiles/ctags ~/.ctags

GITCONFIG=~/.gitconfig
if [ ! -f "$GITCONFIG" ]; then
  cp ~/.dotfiles/gitconfig.global "$GITCONFIG"
else
  echo "$GITCONFIG already exists, skipping"
fi

./osxsetup.sh

mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
ln -s ~/.dotfiles/vim "$XDG_CONFIG_HOME/nvim"
ln -s ~/.dotfiles/vimrc "$XDG_CONFIG_HOME/nvim/init.vim"

#make sure gpg exists for programs that use it
if command -v gpg2 >/dev/null 2>&1; then
  ln -s "$(command -v gpg2)" ~/bin/gpg
fi

mkdir -p ~/.sbt/0.13/plugins
ln -s ~/.dotfiles/sbtplugins.sbt ~/.sbt/0.13/plugins/dotfileplugins.sbt
