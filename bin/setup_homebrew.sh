#install brew is not installed
command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; }

apps=(
  ag
  awscli
  git
  neovim/neovim/neovim
  rbenv
  vim
  watch
  wget
)

brew install ${apps[@]}
