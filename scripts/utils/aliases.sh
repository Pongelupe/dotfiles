#!/usr/bin/env bash

aliases() {
	local edit=false
	[[ "$1" == "-e" ]] && edit=true && shift
	local category=${1:-all}

	if [ "$category" = "all" ]; then
		$edit && $EDITOR ~/.aliases && source ~/.aliases || bat ~/.aliases*
	else
		local file=~/.aliases."$category"
		[ -f "$file" ] && { $edit && $EDITOR "$file" && source "$file" || cat "$file"; } || echo "Category not found. Available: git, docker, dev"
	fi
}
