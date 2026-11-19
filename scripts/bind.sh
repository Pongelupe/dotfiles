#!/bin/bash
# Everything else is managed by chezmoi (see README). Secrets move to chezmoi in #2.
ln -sfn "$DOT_FILES/secrets/.ssh" "$HOME/.ssh"
