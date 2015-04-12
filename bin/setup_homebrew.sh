#install brew is not installed
command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; }

#some essential commands
brew install ctags
brew install git
brew install the_silver_searcher
brew install vim
brew install watch
brew install wget
