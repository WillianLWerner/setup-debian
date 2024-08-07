#!/bin/bash
set -e

# Adição de repositórios adicionais do Debian
apt_list="/etc/apt/sources.list"
echo "# Ativando o repositório de Backports" >> "$apt_list"
echo "deb http://deb.debian.org/debian ${VERSION_CODENAME}-backports main" >> "$apt_list"
echo "deb-src http://deb.debian.org/debian ${VERSION_CODENAME}-backports main" >> "$apt_list"
echo "# Ativando o repositório ftp" >> "$apt_list"
echo "deb http://ftp.debian.org/debian ${VERSION_CODENAME} main" >> "$apt_list"
echo "deb http://ftp.br.debian.org/debian ${VERSION_CODENAME} main" >> "$apt_list"

# Atualização dos pacotes
sudo apt update

# Ativação da configuração de completar o nome dos pacotes na instalação via apt
apt install bash-completion
bashrc="/etc/bash.bashrc"
sed -i '35,41s/^#//' "$bashrc"
source "$bashrc"

# Configuração dos parâmetros de swapiness e cache
sysctl="/etc/sysctl.conf"
echo 'vm.swappiness=10' >> "$sysctl"
echo 'vm.vfs_cache_pressure=50' >> "$sysctl"

