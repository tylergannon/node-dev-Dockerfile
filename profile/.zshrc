autoload -U promptinit; promptinit
prompt pure
bindkey -v
HISTFILE=~/.histfile/histfile
HISTSIZE=1000
APPEND_HIST=true
SAVEHIST=1000
setopt appendhistory

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
