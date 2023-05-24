#!/bin/sh

# Global variables

export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="firefox"
export READER="zathura"
export EXPLORER="thunar"

if [ -n "$(grep ID=ubuntu /etc/os-release)" ]; then
	export DISTRO="ubuntu"
else
	export DISTRO="arch"
fi

# XDG variables
## User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
## System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

#PATHs
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$HOME/.local/go:$HOME/go"
export GOBINPATH="$HOME/.local/go/bin:$HOME/go/bin"
export BIN_HOME="$HOME/.local/usr/bin"
export PATH="$BIN_HOME:$GOBINPATH:$PATH"

# Xorg
#export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export LESSHISTFILE=-

