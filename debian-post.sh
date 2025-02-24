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

# ------------------------------------------------------------------------------ #
# Variáveis

## Cores
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

## Arquivos
BASH="/etc/bash.bashrc"
SWAPPINESS="/etc/sysctl.conf"
TRIM="/etc/cron.daily/trim"
ZRAM="/etc/default/zramswap"

## Programas
PROGRAMAS_PARA_INSTALAR=(
  sudo
  bash-completion
  fwupd
  systemd-oomd
  zram-tools

# ------------------------------------------------------------------------------ #
# Testes e requisitos

## Verificação da conexão com a internet
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

## Remoção das travas do apt
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}

## Atualização dos repositórios e dos pacotes
apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# ------------------------------------------------------------------------------ #
# Funções

## Instalação dos programas
install_apt(){
echo -e "${VERDE}[INFO] - Baixando pacotes do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done
}

## Configuração do bash-completion
bash_completion(){
sed -i '35,41s/^#//' "$BASH"
source "$BASH"

## Ativação do TRIM
trim(){
systemctl enable fstrim.timer
systemctl restart fstrim.timer
echo "#!/bin/sh" >> "$TRIM"
echo "set -e" >> "$TRIM"
echo "LOG=/var/log/trim.log" >> "$TRIM"
echo 'echo "*** $(date -R) ***" >> $LOG' >> "$TRIM"
echo "fstrim -v / >> $LOG" >> "$TRIM"
sudo chmod +x /etc/cron.daily/trim
}

## Configuração da swappiness
swappiness(){
echo 'vm.swappiness=10' >> "$SWAPPINESS"
}

systemd_oomd(){
systemctl enable systemd-oomd
systemctl restart systemd-oomd
}

## Configuração do ZRAM
zram(){
if [ -f "$ZRAM" ]; then
  sed -i 's/^#ALGO=lz4/ALGO=lz4/' "$ZRAM"
  sed -i 's/^#PERCENTAGE=50/PERCENTAGE=50/' "$ZRAM"
}

## Limpeza do sistema
limpar_sistema(){
sudo apt autoclean -y
sudo apt clean -y
}

# ------------------------------------------------------------------------------ #
# Execução
testes_internet
travas_apt
apt_update
install_apt
bash_completion
trim
swappiness
systemd_oomd
zram
apt_update
limpar_sistema

# ------------------------------------------------------------------------------ #
# Finalização
echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
