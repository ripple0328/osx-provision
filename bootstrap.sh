#!/usr/bin/env bash

set -e

SRC_DIRECTORY="$HOME/src"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
# ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible.d"
ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/program/osx-provision"

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

# Modify the PATH
export PATH=/usr/local/bin:$PATH

# Download and install zsh
if [[ ! -x /usr/local/bin/zsh ]]; then
    echo "Info   | Install   | zsh"
    brew install zsh
fi

# Download and install git
if [[ ! -x /usr/local/bin/git ]]; then
    echo "Info   | Install   | git"
    brew install git
fi

# Download and install python
if [[ ! -x /usr/local/bin/python ]]; then
    echo "Info   | Install   | python"
    brew install python --framework --with-brewed-openssl
fi

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
    brew install ansible
fi

# Make the code directory
mkdir -p $SRC_DIRECTORY

# Clone down the Ansible repo
# if [[ ! -d $ANSIBLE_CONFIGURATION_DIRECTORY ]]; then
#     git clone git@bitbucket.org:danieljaouen/ansible-base-box.git $ANSIBLE_CONFIGURATION_DIRECTORY
#     (cd $ANSIBLE_CONFIGURATION_DIRECTORY && git submodule init && git submodule update)
# fi

# Provision the box
ansible-playbook --ask-sudo-pass -i $ANSIBLE_CONFIGURATION_DIRECTORY/inventories/osx $ANSIBLE_CONFIGURATION_DIRECTORY/site.yml --connection=local

