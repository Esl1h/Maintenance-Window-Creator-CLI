ZABBIXTOKEN=$(jq -r .result <(getlogintoken))

DATA='{
    "jsonrpc": "2.0",
    "method": "maintenance.get",
    "params": {
        "output":  [
                            "maintenanceid",
                            "name",
                            "description"
                    ]
    },
    "auth": "'"$ZABBIXTOKEN"'",
    "id": 1
}'

function listzabbix {
    curl -s "$CONFIG_zabbix_url"/api_jsonrpc.php \
        -H "Content-Type: application/json" \
        --data "$DATA"
}

jq '.' <(listzabbix)