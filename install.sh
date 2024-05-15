#!/bin/bash
set -e

# Adiciçã da arquitetura 32 bits ao sistema
dpkg --add-architecture i386 
apt update

# Ativação da configuração de completar o nome dos pacotes na instalação via apt
apt install bash-completion
bashrc="/etc/bash.bashrc"
sed -i '35,41s/^#//' "$bashrc"
source "$bashrc"

# Instalação do pacote sudo no sistema
apt install sudo
adduser root sudo

# Instalação do pacote para o regenciamento da rede pelo terminal
apt install net-tools

# Ativação do programa TRIM para seu SSD
echo '#!/bin/sh' > "$arquivo"
echo 'LOG=/var/log/trim.log' >> "$arquivo"
echo 'echo "*** $(date -R) ***" >> $LOG' >> "$arquivo"
echo 'fstrim -v / >> $LOG' >> "$arquivo"
echo 'fstrim -v /home >> $LOG' >> "$arquivo"
chmod +x /etc/cron.daily/trim

# Configuração dos parâmetros de swapiness e cache
sysctl="/etc/sysctl.conf"
echo 'vm.swappiness=10' >> "$sysctl"
echo 'vm.vfs_cache_pressure=50' >> "$sysctl"

