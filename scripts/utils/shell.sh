#!/usr/bin/env bash

execute_last_command() {
  local cmd="$(fc -ln -1)"
  echo "executing: $cmd"
  eval "$cmd"
}
