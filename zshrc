export LSCOLORS=Gxfxcxdxbxegedabagacad

#Completions
fpath=(/usr/local/share/zsh-completions $fpath)
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -Uz compinit && compinit

# Don't blow up if we think we have a glob and can't match
setopt +o nomatch

set bell-style visible

export EDITOR=vim

#Setup path
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

if [ -f ~/.zshrc.local ] ; then
  # shellcheck source=/dev/null
  source ~/.zshrc.local
fi

if [ -d ~/.dotfiles/environment_imports ] ; then
  for file in ~/.dotfiles/environment_imports/* ; do
    [[ -e $file ]] || break
    # shellcheck source=/dev/null
    source "$file"
  done
fi

case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac


### Bashhub.com Installation
if [ -f ~/.bashhub/bashhub.sh ]; then
  # shellcheck source=/dev/null
  source ~/.bashhub/bashhub.sh
fi

#include any local aliases
if [ -f ~/.aliases.local ] ; then
  # shellcheck source=/dev/null
  source ~/.aliases.local
fi

if [ -f /usr/local/etc/profile.d/z.sh ]; then
  source /usr/local/etc/profile.d/z.sh
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

## Modify path AFTER local settings

#add anything I have in dotfiles
PATH="$HOME/.dotfiles/bin:$PATH"

#prioritive asdf
if type asdf &>/dev/null; then
  PATH="/Users/ssmith/.asdf/shims:$PATH"
fi

if type rbenv &>/dev/null; then
  PATH="$(rbenv root)/shims:$PATH"
fi

if type pyenv &>/dev/null; then
  PATH="$(pyenv root)/shims:$PATH"
fi

# put ~/bin first on PATH
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
#
if [ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
