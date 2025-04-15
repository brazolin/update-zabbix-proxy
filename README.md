# Update Zabbix Proxy - Ubuntu Linux
Atualiza o SO do Zabbix Proxy e envia o resultado para o canal do Teams




## Autores

- [@brazolin](https://www.github.com/brazolin)


## Deploy

Clone o projeto no diretório desejado

```bash
  gitclone https://github.com/brazolin/update-zabbix-proxy
```
Agora edite a linha Token com Webhook

Como criar um token webhook

https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook?tabs=newteams%2Cdotnet



Configurando uma cron:

```bash
  crontab -e
```

Insira uma cron para rodar no momento escolhido como:

0 1 * * 2 /scripts/update-zabbix/update_zabbix.sh >/dev/null 2>&1

no exemplo da linha acima, o script que atualiza o SO 1h da madrugada as terças feiras
