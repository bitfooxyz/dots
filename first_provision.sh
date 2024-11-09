#!/bin/bash

set -eo pipefail

# Exporting local binary path
export PATH="$HOME/.local/bin:/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"

if [[ -n "$DEBUG" ]]; then
   echo "Enable debug output"
   set -x
fi

# Prerequisites for macos
if [[ $(uname) == "Darwin" ]]; then
  # check if xcode is installed on Darwin systems
  if [[ ! -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]; then
    xcode-select --install
    echo -n "xcode installed? Press [y]: "
    read XCODE
    if [[ ! "$XCODE" == "y" ]]; then
      echo "xcode not installed. User interruped."
      exit 1
    fi
  fi
fi

if ! command -v uv &> /dev/null; then
  echo "uv not present downloading and installing uv"
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

echo "Install dependencies from with uv"
uv sync

mkdir -p ./secrets/
if [[ ! -f secrets/become_password_file ]]; then
  echo "Become password file missing!"
  printf "Enter become password: "
  read -s become_password
  printf $become_password > ./secrets/become_password_file
fi

if [[ ! -f secrets/vault_password_file ]]; then
  echo "Vault password file missing!"
  printf "Enter vault password: "
  read -s vault_password
  printf $vault_password > ./secrets/vault_password_file
fi

echo "Install ansible galaxy requirements from requirements.yml"
uvx ansible-galaxy install -r requirements.yml

echo -n "Limit to which host: "
read LIMIT_HOST

echo "Running ansible-playbook"
uvx ansible-playbook play.yml --diff --become-password-file ./secrets/become_password_file --vault-password-file ./secrets/vault_password_file --limit $LIMIT_HOST
