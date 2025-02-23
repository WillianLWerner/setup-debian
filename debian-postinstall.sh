#!/usr/bin/env bash
#
# debian-postinstall.sh - Instala e configura programas para o Debian
#
# Autor: Willian Leonardo Werner
#
# Como usar?
#   ./debian-postinstall.sh
#
set -e

# Atualização a lista de pacotes
sudo apt update

## APT
sudo
bash-completion
systemd-oomd
zram-tools
