#!/bin/bash

mkdir -p ~/bin

files=(
  irbrc 
  psqlrc
  vim
  vimrc
  ctags
)

for item in ${files[*]}; do
  CANDIDATE="$HOME/.$item"
  if [ ! -f "$CANDIDATE" ] && [ ! -d "$CANDIDATE" ]; then
    ln -s "$HOME/.dotfiles/$filename" "$CANDIDATE"
  else
    echo "$CANDIDATE already exists, skipping"
  fi
done

GITCONFIG=~/.gitconfig
if [ ! -f "$GITCONFIG" ]; then
  cp ~/.dotfiles/gitconfig.global "$GITCONFIG"
else
  echo "$GITCONFIG already exists, skipping"
fi

#create .config groups if they exist
cd .config || exit
for filename in *; do
  CANDIDATE="$HOME/.config/$filename"
  if [ ! -f "$CANDIDATE" ] && [ ! -d "$CANDIDATE" ]; then
    ln -s "$HOME/.dotfiles/.config/$filename $CANDIDATE"
  else
    echo "$CANDIDATE already exists, skipping"
  fi
done

./osxsetup.sh

mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
ln -s ~/.dotfiles/vim "$XDG_CONFIG_HOME/nvim"
ln -s ~/.dotfiles/vimrc "$XDG_CONFIG_HOME/nvim/init.vim"

#make sure gpg exists for programs that use it
if command -v gpg2 >/dev/null 2>&1; then
  ln -s "$(command -v gpg2)" ~/bin/gpg
fi

mkdir -p ~/.sbt/0.13/plugins
mkdir -p ~/.sbt/1.0/plugins
ln -s ~/.dotfiles/sbtplugins.sbt ~/.sbt/0.13/plugins/dotfileplugins.sbt
ln -s ~/.dotfiles/sbtplugins.sbt ~/.sbt/1.0/plugins/dotfileplugins.sbt
