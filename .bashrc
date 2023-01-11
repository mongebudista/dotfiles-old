#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="[\[$(tput sgr0)\]\[\033[38;5;228m\]\u\[$(tput sgr0)\]@🔰\W]>\[$(tput sgr0)\]"

alias ls="exa --icons"
alias cat="bat --style=auto"
alias pf="pfetch"
alias vim="nvim"
alias dev="~/scripts/tmux-dev.sh"
alias lg="lazygit"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
