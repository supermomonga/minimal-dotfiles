# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
# Emacs
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# move without cd command
setopt AUTO_CD

zstyle :compinstall filename '/home/lvr/.zshrc'
autoload -Uz compinit && compinit
# pure
autoload -U promptinit && promptinit
prompt pure
# Alias
alias rl="source ~/.zshrc"
