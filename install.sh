#!/bin/bash

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
adduser willian sudo

# Instalação do pacote para o regenciamento da rede pelo terminal
apt install net-tools

# Ativação do programa TRIM para seu SSD
#trim="/etc/cron.daily/trim"
#echo '#!/bin/sh' > "$trim"
#echo 'LOG=/var/log/trim.log' >> "$trim"
#echo 'echo "*** $(date -R) ***" >> $LOG' >> "$trim"
#echo 'fstrim -v / >> $LOG' >> "$trim"
#echo 'fstrim -v /home >> $LOG' >> "$trim"
#chmod +x /etc/cron.daily/trim

# Configuração dos parâmetros de swapiness e cache
sysctl="/etc/sysctl.conf"
echo 'vm.swappiness=10' >> "$sysctl"
echo 'vm.vfs_cache_pressure=50' >> "$sysctl"

