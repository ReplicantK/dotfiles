# shell history
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# macos environment
if [[ "$OSTYPE" =~ ^darwin ]]; then
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
if [[ "$OSTYPE" =~ ^linux ]]; then
  export PATH="/usr/sbin:$PATH"
  alias ls='ls --color=auto'
  alias grep='ls --color=auto'
fi

# base for terminal color
autoload -U colors && colors

# auto complete
autoload -U compinit && compinit

# ps1 theme
PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "

# completion, menu, all with color
zstyle ':completion:*' completer _complete
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'

# aliases
alias bc='bc -l'
alias weatherf="curl 'wttr.in/Riverside?format=%l+:+%c+%t+%h+%m+%M+%T+\n'"
alias weatherc="curl 'wttr.in/Riverside?m&format=%l+:+%c+%t+%h+%m+%M+%T+\n'"
alias mpv='mpv --profile=1080'
alias mpvhardware='mpv --profile=hardware'
alias mpvhigh='mpv --profile=high'
alias mpvaudio='mpv --profile=novideo'
alias mpvsingle='mpv --profile=single'
