set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g theme_display_node yes
set -g theme_display_user no
set -g theme_hide_hostname no
set -g theme_hostname no

set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes

# aliases
alias ls "ls -l"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git

alias dev "cd ~/Dev"
alias ide "~/scripts/tmux-dev.sh"

alias sf "~/scripts/sysinfo"

command -qv nvim && alias vim nvim

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

set -gx PATH ~/.emacs.d/bin $PATH
set -g  PATH ~/.dotnet/tool $PATH
set -gx PATH ~/.poetry/bin $PATH

test -s /home/jarco/.nvm-fish/nvm.fish; and source /home/jarco/.nvm-fish/nvm.fish
