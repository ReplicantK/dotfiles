# shell history
export HISTFILE="$HOME/.sh_history"

# max number of commands stored in history file
export HISTFILESIZE=1000000000

# current session command memory 
export HISTSIZE=1000000000

# go path
export GOPATH="$HOME/.go"

# g++ compiler
export MallocNanoZone=0

# color highlighting and search result 30% of the screen for man pages
export MANPAGER="less -j.3 -R --use-color -Ddg -Du+y"

# macos environment
if [[ "$OSTYPE" == darwin* ]]
then
  # node
  #export NVM_DIR="$HOME/.nvm"
  #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  # This loads nvm bash_completion
  #[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

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

  # macos lode LO
  export LODE_HOME="$HOME/libreoffice/lode"
  export CCACHE_CPP2=YES
  export PATH="${LODE_HOME}/opt/bin:${PATH}"

  # m4
  #export PATH="/usr/local/opt/m4/bin:$PATH"

  # dirty trick to get cpu and gpu temp in macos
  alias lstemps='sudo powermetrics --samplers smc | grep -i "temp"'
fi

# linux environment
if [[ "$OSTYPE" == linux* ]]
then
  export PATH="/usr/sbin:$PATH"
  alias ls='ls --color=auto'
fi

# ssh key for mininet
if [[ "$USER" == mininet* ]]
then
  /usr/bin/keychain $HOME/.ssh/sevenwhiteclouds
  source $HOME/.keychain/mininet-vm-sh
fi

# pipx
export PATH="$HOME/.local/bin:${PATH}"

# all zsh specific options here
# colors in particular need to come after because color setup is declared up top
if [[ "$SHELL" == /bin/zsh* ]]
then
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

  # ps1 themes
  # old
  #PROMPT="%m %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[red]}%}»%{${reset_color}%} "

  # home
  #PROMPT="%F{green}%n@%m%f %F{blue}%4~%f%(?.. %F{red}%?%f) %F{blue}$%f "

  # arch inspired
  #PROMPT="%F{green}[%n@%m%f %F{blue}%1~%f%(?.. %F{red}%?%f)%F{blue}]$%f "

  # zep
  PROMPT="%F{green}%n@%m%f%F{blue}[%1~]%f%(?..%F{red}%?%f)%F{blue}$%f "

  # completion, menu, all with color
  zstyle ':completion:*' completer _complete
  zstyle ':completion:*' menu select
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
fi

# universal aliases
alias ssh-no-pass-test='ssh -o PubkeyAuthentication=no -o PreferredAuthentications=password'
alias grep='grep --color=auto'
alias bc='bc -l'
alias mpv='mpv --profile=1080'
alias mpv-hardware='mpv --profile=hardware'
alias mpv-high='mpv --profile=high'
alias mpv-audio='mpv --profile=novideo'
alias mpv-single='mpv --profile=single'

# open a rdp connection, using sensible settings
function rdp() {
  if [ -z $2 ]
  then
    xfreerdp /v:$1 /dynamic-resolution /from-stdin /sound /clipboard:direction-to:all
  else
    xfreerdp /v:$1 /dynamic-resolution /from-stdin /sound /clipboard:direction-to:all /drive:RDPMountPoint,$2
  fi
}
