#!/usr/bin/env bash

#install brew if not installed
command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; }

#install asdf if not installed
command -v asdf >/dev/null 2>&1 || { git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0 ; }

brew tap Seanstoppable/random 2> /dev/null
brew tap caskroom/cask 2> /dev/null
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

cask_apps=(
  bitbar
  blockblock
  cyberduck
  dnscrypt
  flux
  gimp
  keka
  oversight
  postman
  qbittorrent
  veracrypt
  yed
)

MISSING=$(comm -1 -3 <(brew list) <(for X in "${brew_apps[@]}"; do echo "${X}"; done|sort))
INSTALLED=$(comm -1 -2 <(brew list) <(for X in "${brew_apps[@]}"; do echo "${X}"; done|sort) | tr '\n' ' ')

CASK_MISSING=$(comm -1 -3 <(brew cask list) <(for X in "${cask_apps[@]}"; do echo "${X}"; done|sort))
CASK_INSTALLED=$(comm -1 -2 <(brew cask list) <(for X in "${cask_apps[@]}"; do echo "${X}"; done|sort) | tr '\n' ' ')

if [[ ! -z "${MISSING}" ]]; then
  echo "Installing missing program ${MISSING}"
  brew install "${MISSING}"
fi

if [[ ! -z "${INSTALLED}" ]]; then
  brew upgrade "${INSTALLED}" 2> /dev/null
fi

if [[ ! -z "${CASK_MISSING}" ]]; then
  echo "Installing missing cask ${CASK_MISSING}"
  brew cask install "${CASK_MISSING}"
fi

if [[ ! -z "${CASK_INSTALLED}" ]]; then
  brew cask update "${CASK_INSTALLED}" 2> /dev/null
fi

pip_packages=(
  ansible-lint
  vim-vint
  yamllint
)

MISSING=$(comm -1 -3 <(pip list --format=columns | awk -F" " '{print $1}') <(for X in "${pip_packages[@]}"; do echo "${X}"; done|sort))
INSTALLED=$(comm -1 -2 <(pip list --format=columns | awk -F" " '{print $1}') <(for X in "${pip_packages[@]}"; do echo "${X}"; done|sort) | tr '\n' ' ')

if [[ ! -z "${MISSING}" ]]; then
  echo "Installing missing program ${MISSING}"
  pip install "${MISSING}"
fi

gems=(
  sqlint
)

MISSING=$(comm -1 -3 <(gem list --no-versions ) <(for X in "${gems[@]}"; do echo "${X}"; done|sort))
INSTALLED=$(comm -1 -2 <(gem list --no-versions ) <(for X in "${gems[@]}"; do echo "${X}"; done|sort) | tr '\n' ' ')

if [[ ! -z "${MISSING}" ]]; then
  echo "Installing missing program ${MISSING}"
  gem install "${MISSING}"
fi
