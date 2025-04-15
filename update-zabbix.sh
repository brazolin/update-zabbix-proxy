#!/bin/bash

# Obter hostname e IP da máquina
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')  # Capturar o primeiro IP retornado

# Obter distribuição do Linux e versão
DISTRO=$(lsb_release -d | awk -F: '{print $2}' | sed 's/^ *//g')  # Ex: "Ubuntu 22.04 LTS"

# Variáveis
ATTACHMENT="/tmp/update_log.txt"

# Webhook do Microsoft Teams
TEAMS_WEBHOOK_URL="Token Teams Channel"

# Parar o serviço do Zabbix Proxy
echo "Parando o Zabbix Proxy..." > /tmp/update_log.txt
systemctl stop zabbix-proxy >> /tmp/update_log.txt 2>&1

# Atualizar a lista de pacotes
echo "Atualizando lista de pacotes..." >> /tmp/update_log.txt
apt-get update >> /tmp/update_log.txt 2>&1

# Fazer o upgrade dos pacotes
echo "Atualizando pacotes..." >> /tmp/update_log.txt
apt-get upgrade -y >> /tmp/update_log.txt 2>&1

# Reiniciar o serviço do Zabbix Proxy
echo "Reiniciando o Zabbix Proxy..." >> /tmp/update_log.txt
systemctl start zabbix-proxy >> /tmp/update_log.txt 2>&1

# Ler o conteúdo do arquivo de log e separar as linhas
LOG_CONTENT=$(cat $ATTACHMENT | sed 's/$/\n/g')  # Adiciona uma quebra de linha ao final de cada linha

# Mensagem de status com a distribuição do Linux e o nome do host em negrito
MESSAGE="Atualização via **$DISTRO** concluída no host: **$HOSTNAME** (IP: $IP_ADDRESS). Confira o log abaixo:\n\n$LOG_CONTENT"

# Enviar mensagem para o Microsoft Teams
curl -H "Content-Type: application/json" -X POST -d "{
  \"text\": \"$MESSAGE\"
}" $TEAMS_WEBHOOK_URL

# Limpar o arquivo de log temporário
rm -f $ATTACHMENT
