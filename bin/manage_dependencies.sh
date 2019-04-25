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
  bash-completion@2
  git
  gnupg
  grip
  hadolint
  htop
  lz4
  pwgen
  shellcheck
  the_silver_searcher
  tig
  vim
  watch
  wget
)

__install "brew list" "brew install" "brew upgrade" "${brew_apps[@]}"

cask_apps=(
#  bitbar
  blockblock
  cyberduck
#  dnscrypt
  flux
  gimp
  iterm2
  keepassxc
  keka
#  oversight
  postman
#  qbittorrent
#  veracrypt
  vlc
  yed
)

__install "brew cask list" "brew cask install" "brew cask upgrade" "${cask_apps[@]}"

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

#Other bash completions
COMPLETION_DIR=~/.local/share/bash-completion/completions/
mkdir -p $COMPLETION_DIR
#Maven
wget https://raw.github.com/dimaj/maven-bash-completion/master/bash_completion.bash \
  --output-document $COMPLETION_DIR/mvn
#docker-compose
wget https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose \
  --output-document $COMPLETION_DIR/docker-compose
