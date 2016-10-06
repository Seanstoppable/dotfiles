#install brew is not installed
command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; }

brew tap Seanstoppable/random 2> /dev/null
brew tap caskroom/cask 2> /dev/null
brew tap universal-ctags/universal-ctags 2> /dev/null

#head only formula
brew install --HEAD universal-ctags 2> /dev/null

brew_apps=(
  awscli
  aws-shell
  bash-completion
  ctags
  git
  grip
  gpg
  htop
  neovim
  pwgen
  rbenv
  the_silver_searcher
  tig
  vim
  watch
  wget
)

cask_apps=(
  bitbar
  soundcast
)

MISSING=$(comm -1 -3 <(brew list) <(for X in "${brew_apps[@]}"; do echo "${X}"; done|sort))
INSTALLED=$(comm -1 -2 <(brew list) <(for X in "${brew_apps[@]}"; do echo "${X}"; done|sort) | tr '\n' ' ')

CASK_MISSING=$(comm -1 -3 <(brew cask list) <(for X in "${cask_apps[@]}"; do echo "${X}"; done|sort))
CASK_INSTALLED=$(comm -1 -2 <(brew cask list) <(for X in "${cask_apps[@]}"; do echo "${X}"; done|sort) | tr '\n' ' ')

if [[ ! -z ${MISSING} ]]; then
  brew install ${MISSING}
fi

if [[ ! -z ${INSTALLED} ]]; then
  brew upgrade ${INSTALLED} 2> /dev/null
fi

if [[ ! -z ${CASK_MISSING} ]]; then
  brew cask install ${CASK_MISSING} 
fi

if [[ ! -z ${CASK_INSTALLED} ]]; then
  brew cask upgrade ${CASK_INSTALLED} 2> /dev/null
fi
