#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1="[\[$(tput sgr0)\]\[\033[38;5;228m\]\u\[$(tput sgr0)\]@🔰\W]>\[$(tput sgr0)\]"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
