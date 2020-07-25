#!/usr/bin/env bash

# Function wrapper to handle diffs and selectively install/upgrade
__install() {
  LIST_COMMAND=$1
  INSTALL_COMMAND=$2
  UPDATE_COMMAND=$3
  shift
  shift
  shift
  APPS=("$@")

  MISSING=$(comm -1 -3 <($LIST_COMMAND) <(for X in $APPS; do echo "${X}"; done|sort))
  INSTALLED=$(comm -1 -2 <($LIST_COMMAND) <(for X in $APPS; do echo "${X}"; done|sort) | tr '\n' ' ')
  
  if [[ -n "${MISSING}" ]]; then
    echo "Installing missing program ${MISSING}"
    $INSTALL_COMMAND "$MISSING"
  fi

  if [[ -n "${INSTALLED}" ]]; then
    $UPDATE_COMMAND "$INSTALLED" 2> /dev/null
  fi
}

#install brew if not installed
command -v brew >/dev/null 2>&1 || { /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" ; }

#install asdf and plugin if not installed
command -v asdf >/dev/null 2>&1 || { git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3 ; }
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git 2> /dev/null
asdf plugin-add java https://github.com/halcyon/asdf-java.git 2> /dev/null
asdf plugin-add python https://github.com/tuvistavie/asdf-python.git 2> /dev/null
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git 2> /dev/null
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2> /dev/null

brew bundle --file=~/.dotfiles/Brewfile
brew bundle --file=~/.dotfiles/Brewfile.$(hostname)

pip_packages=(
  ansible-lint
  vim-vint
  yamllint
)

__install "pip list --format=columns | awk -F" "pip install" "pip install -U" "${pip_packages[@]}"

gems=(
  sqlint
)

__install "gem list --no-versions" "gem install" "gem update" "${gems[@]}"
