############
#  .zshrc  #
############

source "$HOME/.config/profile"
source "$XDG_CONFIG_HOME/aliasrc"

if [ "$DISTRO" = "arch" ]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /usr/share/git/completion/git-prompt.sh
	PS1='%B%F{yellow}%~%f%b '
elif [ "$DISTRO" = "ubuntu" ]; then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /etc/bash_completion.d/git-prompt
	PS1='%B%F{magenta}%T %~%f%b '
fi

setopt appendhistory autocd extendedglob nomatch notify
setopt HIST_IGNORE_DUPS
unsetopt beep

# Plugins
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit && compinit
autoload -U colors && colors

setopt PROMPT_SUBST

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
#GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_SHOWUPSTREAM="auto"

RPROMPT='$(__git_ps1 " %s")'

HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE=10000
SAVEHIST=10000

mkdirgo() { mkdir "$1" && cd "$1"; }

# Show hidden files in fzf
export FZF_DEFAULT_COMMAND="find . -not -path \"*.git/*\""

# Change the title of the terminal
precmd() { echo -ne "\e]1;$(pwd | sed "s|$HOME|~|")\a"; }
preexec() { echo -ne "\e]1;$1\a"; }

# Fixes for the Home, End and Delete buttons
bindkey "\e[H" beginning-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[P" delete-char
bindkey "\e[3~" delete-char

# tmux-sessionizer
sessionize-tmux() { tmux-sessionizer }
zle -N sessionize-tmux
bindkey "^t" sessionize-tmux

