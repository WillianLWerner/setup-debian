# Configuração inicial do Debian

## Sumário
  1. [Programas necessários](#1-programas-necessários)
  2. [Instalação e execução do script](#2-instalação-e-execução-do-script)

# 1. Programas necessários

Para a execução do script de configuração você precisará instalar o `wget` da seguinte forma:
```bash
apt install wget
```

# 2. Instalação e execução do script


```bash
cd /tmp
wget https://raw.githubusercontent.com/WillianLWerner/setup-debian/main/debian-post.sh -O setup.sh
chmod +x setup.sh
./setup.sh
```
