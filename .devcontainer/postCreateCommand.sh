#!/bin/sh
script_user=`whoami`
script_dir=$(realpath "$(dirname "$0")")

echo "USER:" ${script_user}
echo "DIR:" ${script_dir}
echo

# Install GitHub CLI extension for actions lock
# Update command `gh actions-lock --no-narrow`
gh extension install github/gh-actions-lock
