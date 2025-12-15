#!/usr/bin/env bash

category=${1:-all}

if [ "$category" = "all" ]; then
	bat ~/.aliases*
else
	bat ~/.aliases."$category" 2>/dev/null || echo "Category not found. Available: git, docker, amazon, dev"
fi
