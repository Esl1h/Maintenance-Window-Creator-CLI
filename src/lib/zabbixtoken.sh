#!/bin/bash
function getlogintoken {
curl -s "$CONFIG_zabbix_url"/api_jsonrpc.php \
        -H "Content-Type: application/json" \
        --data '{
                "jsonrpc": "2.0",
                "method": "user.login",
                "params": {
                "user": "'"$CONFIG_zabbix_user"'",
                "password": "'"$CONFIG_zabbix_password"'"
                },
                "id": 1,
                "auth": null
                }'
}