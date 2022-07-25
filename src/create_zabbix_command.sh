HOST=${args[SERVICE_NAME]}
START_DATE=$(echo ${args[START_TIME]})
START_WINDOW=${START_DATE/_/T}
START_EPOCH=$(gdate --date="$START_WINDOW" +%s)
END_DATE=$(echo ${args[END_TIME]})
END_WINDOW=${END_DATE/_/T}
END_EPOCH=$(gdate --date="$END_WINDOW" +%s)

ZABBIXTOKEN=$(jq -r .result <(getlogintoken))

# curl abaixo pode retornar uma lista!
function gethostid {
    curl -s "$CONFIG_zabbix_url"/api_jsonrpc.php \
            -H "Content-Type: application/json" \
            --data '{
                "jsonrpc": "2.0",
                "method": "host.get",
                "params": {
                    "output": [
                            "hostid",
                            "host"
                    ],
                    "selectInterfaces": [
                            "interfaceid",
                            "ip"
                    ]
                },
                "id": 2,
                "auth": "'"$ZABBIXTOKEN"'"
                }' | jq -r '.result[] | "\(.hostid)=\(.host)" ' | grep -i $HOST | cut -d '=' -f 1
}

# array:
HOSTID=( $(gethostid) )
HOSTIDGROUP=$(sed -E "s/([[:alnum:]]+)/\"&\"/g;s/ /,/g" <<< ${HOSTID[@]})

DATAZABBIX='{
            "jsonrpc": "2.0",
            "method": "maintenance.create",
            "params": {
                "name": "'"$HOST"'",
                "active_since": "'"$START_EPOCH"'",
                "active_till": "'"$END_EPOCH"'",
                "tags_evaltype": 0,
                "hostids": [
                    '"$HOSTIDGROUP"'
                ],
                "timeperiods": [
                    {
                        "timeperiod_type": 0
                    }
                ]
            },
            "auth": "'"$ZABBIXTOKEN"'",
            "id": 1
}'

function createzabbix {
    curl -s "$CONFIG_zabbix_url"/api_jsonrpc.php \
        -H "Content-Type: application/json" \
        --data "$DATAZABBIX"
}

jq '.' <(createzabbix)