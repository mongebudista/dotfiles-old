#
# ~/.bashrc
#
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias pf='pfetch'
alias ls='ls --color=auto'
alias ll='exa --icons'
alias dev='~/scripts/tmux-dev.sh'
alias lg='lazygit'
alias vimcfg='nvim ~/.config/nvim'
alias i3cfg='nvim ~/.config/i3/config'

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec
