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

if [[ ! -d .venv ]]; then
  echo "Create .venv virtualenv"
  python3 -m venv .venv
fi

echo "Source venv and install dependencies from requirements.lock"
source .venv/bin/activate
pip3 install ansible

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
ansible-galaxy install -r requirements.yml

echo -n "Enter play name [without .yml]: "
read PLAYBOOK

echo "Running ansible-playbook"
ansible-playbook plays/${PLAYBOOK}.yml --diff --become-password-file ./secrets/become_password_file --vault-password-file ./secrets/vault_password_file $@
