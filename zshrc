#!/bin/sh

# this script is not entirely portable (posix) because of the aliases being used
# future iterations of this script may include shell functions as replacements

# shell history
export HISTFILE="$HOME/.sh_history"

# max number of commands stored in history file
export HISTFILESIZE=1000000000

# current session command memory 
export HISTSIZE=1000000000

# macos environment
if [ $(echo "$OSTYPE" | grep -c 'darwin') -gt 0 ]; then
  # node
  #export NVM_DIR="$HOME/.nvm"
  #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  #[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # ruby
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # android emu
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools

  # mongodb
  export PATH="/usr/local/opt/mongodb-community@5.0/bin:$PATH"

  # jdk to path 
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
  export CPPFLAGS="-I/usr/local/opt/openjdk/include"

  # enable color across entire shell, and add to homebrew path -- mac
  export CLICOLOR='1'
  export LSCOLORS='ExGxFxdxCxDxDxhbadacec'
  export PATH="/usr/local/sbin:$PATH"
fi

# linux environment
if [ $(echo "$OSTYPE" | grep -c 'linux') -gt 0 ]; then
  export PATH="/usr/sbin:$PATH"
  alias ls='ls --color=auto'
fi

# ssh key for mininet
if [ $(echo "$USER" | grep -c 'mininet') -gt 0 ]; then
  /usr/bin/keychain $HOME/.ssh/sevenwhiteclouds
  source $HOME/.keychain/mininet-vm-sh
fi

# all zsh specific options here
# colors in particular need to come after because color setup is declared up top
if [ $(echo "$SHELL" | grep -c 'zsh') -gt 0 ]; then
  # history that is saved from the current session into the history file
  export SAVEHIST=10000000
  # write to the history file immediately
  setopt INC_APPEND_HISTORY
  # only save original commands and remove old duplicates
  setopt HIST_IGNORE_ALL_DUPS

  # base for terminal color
  autoload -U colors && colors
  # auto complete
  autoload -U compinit && compinit

  # ps1 theme
  PROMPT="%m %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[red]}%}»%{${reset_color}%} "

  # completion, menu, all with color
  zstyle ':completion:*' completer _complete
  zstyle ':completion:*' menu select
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
fi

# aliases
alias grep='grep --color=auto'
alias bc='bc -l'
alias weatherf="curl 'wttr.in/Riverside?format=%l+:+%c+%t+%h+%m+%M+%T+\n'"
alias weatherc="curl 'wttr.in/Riverside?m&format=%l+:+%c+%t+%h+%m+%M+%T+\n'"
alias mpv='mpv --profile=1080'
alias mpvhardware='mpv --profile=hardware'
alias mpvhigh='mpv --profile=high'
alias mpvaudio='mpv --profile=novideo'
alias mpvsingle='mpv --profile=single'
