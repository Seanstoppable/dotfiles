#!/bin/bash

apps=(
  awscli
  git
  neovim/neovim/neovim
  rbenv
  the_silver_searcher
  wget
)

brew install ${apps[@]}
