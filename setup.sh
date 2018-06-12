#!/bin/bash

DOTFILES_HOME="$HOME/.dotfiles"
VERBOSE=false

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
    ln -s "$DOTFILES_HOME/$filename" "$CANDIDATE"
  else
    if [ $VERBOSE = true ]; then
      echo "$CANDIDATE already exists, skipping"
    fi
  fi
done

GITCONFIG=~/.gitconfig
if [ ! -f "$GITCONFIG" ]; then
  cp "$DOTFILES_HOME/gitconfig.global $GITCONFIG"
else
  if [ $VERBOSE = true ]; then
    echo "$GITCONFIG already exists, skipping"
  fi
fi

#create .config groups if they exist
cd .config || exit
for filename in *; do
  CANDIDATE="$HOME/.config/$filename"
  if [ ! -f "$CANDIDATE" ] && [ ! -d "$CANDIDATE" ]; then
    ln -s "$DOTFILES_HOME/.config/$filename $CANDIDATE"
  else
    if [ $VERBOSE = true ]; then
      echo "$CANDIDATE already exists, skipping"
    fi
  fi
done

./osxsetup.sh

mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
ln -s "$DOTFILES_HOME/vim $XDG_CONFIG_HOME/nvim"
ln -s "$DOTFILES_HOME/vimrc $XDG_CONFIG_HOME/nvim/init.vim"

#make sure gpg exists for programs that use it
if command -v gpg2 >/dev/null 2>&1; then
  ln -s "$(command -v gpg2)" ~/bin/gpg
fi

mkdir -p ~/.sbt/0.13/plugins
mkdir -p ~/.sbt/1.0/plugins
ln -s "$DOTFILES_HOME/sbtplugins.sbt" ~/.sbt/0.13/plugins/dotfileplugins.sbt
ln -s "$DOTFILES_HOME/sbtplugins.sbt" ~/.sbt/1.0/plugins/dotfileplugins.sbt
