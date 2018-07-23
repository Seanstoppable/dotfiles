#!/bin/bash

DOTFILES_HOME="$HOME/.dotfiles"
VERBOSE=false

mkdir -p ~/bin

puts(){
  if [ $VERBOSE = true ]; then
    echo "$1"
  fi
}

files=(
  irbrc 
  psqlrc
  vim
  vimrc
  ctags
)

for filename in ${files[*]}; do
  CANDIDATE="$HOME/.$filename"
  if [ ! -f "$CANDIDATE" ] && [ ! -d "$CANDIDATE" ]; then
    ln -s "$DOTFILES_HOME/$filename" "$CANDIDATE"
  else
    puts "$CANDIDATE already exists, skipping"
  fi
done

GITCONFIG=~/.gitconfig
if [ ! -f "$GITCONFIG" ]; then
  cp "$DOTFILES_HOME/gitconfig.global $GITCONFIG"
else
  puts "$GITCONFIG already exists, skipping"
fi

#create .config groups if they exist
cd .config || exit
for filename in *; do
  CANDIDATE="$HOME/.config/$filename"
  if [ ! -f "$CANDIDATE" ] && [ ! -d "$CANDIDATE" ]; then
    ln -s "$DOTFILES_HOME/.config/$filename $CANDIDATE"
  else
    puts "$CANDIDATE already exists, skipping"
  fi
done

mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"

if [ ! -d "$XDG_CONFIG_HOME/nvim" ]; then
  ln -s "$DOTFILES_HOME/vim $XDG_CONFIG_HOME/nvim"
else
  puts "$XDG_CONFIG_HOME/nvim already exists, skipping"
fi

if [ ! -f "$XDG_CONFIG_HOME/nvim/init.vim" ]; then
  ln -s "$DOTFILES_HOME/vimrc $XDG_CONFIG_HOME/nvim/init.vim"
else
  puts "$XDG_CONFIG_HOME/nvim/init.vim already exists, skipping"
fi

#make sure gpg exists for programs that use it
if command -v gpg2 >/dev/null 2>&1; then
  ln -s "$(command -v gpg2)" ~/bin/gpg
fi

mkdir -p ~/.sbt/0.13/plugins
mkdir -p ~/.sbt/1.0/plugins
ln -s "$DOTFILES_HOME/sbtplugins.sbt" ~/.sbt/0.13/plugins/dotfileplugins.sbt
ln -s "$DOTFILES_HOME/sbtplugins.sbt" ~/.sbt/1.0/plugins/dotfileplugins.sbt
