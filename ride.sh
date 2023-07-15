#!/bin/bash

[ -z "$1" ] && exit

[ "$USER" = "root" ] && echo "Please do not run this as root" >&2 && exit 1

INSTALL_PATH="$HOME/.config"
RIDE_YAML="$INSTALL_PATH/ride.yaml"
PACKAGE_LIST="$INSTALL_PATH/packages"
AUR_INSTALL_PATH="$HOME/.local/aur"
GIT_INSTALL_PATH="$HOME/.local/src"

if [ -z "$(command -v yq)" ]; then
	sudo pacman -Sy go-yq
fi

parse() {
	yq "$1" $RIDE_YAML | grep -v '^null$' | sed 's/^- //' | sed 's/^>//'
}

install_module() {
	module="$1"
	IFS=$'\n'

	echo "RIDE: installing module $module"

	# Pre install hooks
	for cmd in "$(parse .$module.hooks.pre)"; do
		echo "RIDE: $module pre hook: $cmd"
		eval "$cmd"
	done

	# Install packages from the main repos
	echo "RIDE: installing $module packages from main repos"
	parse ".$module.packages.main[]" | sudo pacman -Sy --needed --noconfirm -

	# Install AUR packages
	for package in $(parse .$module.packages.aur[]); do
		echo "RIDE: $module AUR install: $package"
		[ ! -d "$AUR_INSTALL_PATH" ] && mkdir -p "$AUR_INSTALL_PATH"
		cd "$AUR_INSTALL_PATH" \
			&& git clone "https://aur.archlinux.org/$package.git" \
			&& cd "$package" \
			&& makepkg -si --noconfirm \
			|| echo "RIDE: could not install AUR package: $package" >&2
	done

	# Install git packages
	# Need to check first if repo exists?
	for repo in $(parse .$module.packages.git[]); do
		echo "RIDE: $module installing from git: $repo"
		[ ! -d "$GIT_INSTALL_PATH" ] && mkdir -p "$GIT_INSTALL_PATH"
		dir=$(basename "$repo" | sed 's/\.git$//')
		cd "$GIT_INSTALL_PATH" \
			&& git clone "$repo" \
			&& cd "$dir" \
			&& make && sudo make install \
			|| echo "RIDE: could not install from git repo: $repo" >&2
	done

	# Post install hooks
	for cmd in "$(parse .$module.hooks.post)"; do
		echo "RIDE: $module post hook: $cmd"
		eval "$cmd"
	done
}

for m in $@; do
	install_module $m
done

