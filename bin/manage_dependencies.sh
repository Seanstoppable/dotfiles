#!/usr/bin/env bash

# Function wrapper to handle diffs and selectively install/upgrade
__install() {
  MISSING=$(comm -1 -3 <($1) <(for X in $2; do echo "${X}"; done|sort))
  INSTALLED=$(comm -1 -2 <($1) <(for X in $2; do echo "${X}"; done|sort) | tr '\n' ' ')
  
  if [[ -n "${MISSING}" ]]; then
    echo "Installing missing program ${MISSING}"
    $3 "$MISSING"
  fi

  if [[ -n "${INSTALLED}" ]]; then
    $4 "$INSTALLED" 2> /dev/null
  fi
}

#install brew if not installed
command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; }

#install asdf and plugin if not installed
command -v asdf >/dev/null 2>&1 || { git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3 ; }
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git 2> /dev/null
asdf plugin-add java https://github.com/skotchpine/asdf-java.git 2> /dev/null
asdf plugin-add python https://github.com/tuvistavie/asdf-python.git 2> /dev/null
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git 2> /dev/null
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2> /dev/null

brew tap Seanstoppable/random 2> /dev/null
brew tap caskroom/cask 2> /dev/null
brew tap caskroom/versions 2> /dev/null
brew tap universal-ctags/universal-ctags 2> /dev/null

#head only formula
brew install --HEAD universal-ctags 2> /dev/null

brew_apps=(
  awscli
  aws-shell
  bash-completion
  git
  gnupg2
  grip
  hadolint
  htop
  lz4
  mercurial
  pwgen
  shellcheck
  the_silver_searcher
  tig
  vim
  watch
  wget
)

__install "brew list" "${brew_apps[@]}" "brew install" "brew upgrade"

cask_apps=(
  bitbar
  blockblock
  cyberduck
#  dnscrypt
  flux
  gimp
  keepassxc
#  keka
#  oversight
  postman
#  qbittorrent
#  veracrypt
  vlc
  yed
)

__install "brew cask list" "${cask_apps[@]}" "brew cask install" "brew cask upgrade"

pip_packages=(
  ansible-lint
  vim-vint
  yamllint
)

__install "pip list --format=columns | awk -F" "${pip_packages[@]}" "pip install" "pip install -U"

gems=(
  sqlint
)

__install "gem list --no-versions" "${gems[@]}" "gem install" "gem update"
