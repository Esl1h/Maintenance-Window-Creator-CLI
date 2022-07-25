TOKEN=$(getacesstoken | cut -d "\"" -f 4)

MONITOR=${args[SERVICE_NAME]}
START_DAY=$(cut -d '_' -f 1 <(echo "${args[START_TIME]}"))
START_HOUR=$(cut -d '_' -f 2 <(echo "${args[START_TIME]}"))
END_DAY=$(cut -d '_' -f 1 <(echo "${args[END_TIME]}"))
END_HOUR=$(cut -d '_' -f 2 <(echo "${args[END_TIME]}"))

function searchmonitorid {
    curl -s https://www.site24x7.com/api/monitors \
    -H "Authorization: Zoho-oauthtoken $TOKEN" | jq -r '.data[] | "\(.display_name) =  \(.monitor_id)" ' | grep -i "$MONITOR" | cut -d '=' -f 2
}

MONITORID=$(searchmonitorid | awk '{print $1}')



DATA='{
    "maintenance_type": 3,
    "selection_type": 2,
    "start_time": "'"$START_HOUR"'",
    "end_time": "'"$END_HOUR"'",
    "display_name": "Once maintenance",
    "description": "Maintenance test",
    "monitors": [
        "'"$MONITORID"'"
        ],
    "start_date": "'"$START_DAY"'",
    "end_date": "'"$END_DAY"'",
    "perform_monitoring":true
}'

function create24x7 {
curl -s --compressed  https://www.site24x7.com/api/maintenance \
        -H "Content-Type: application/json;charset=UTF-8" \
        -H "Accept: application/json; version=2.0" \
        -H "Authorization: Zoho-oauthtoken $TOKEN" \
        --data "$DATA"
}

jq '.' <(create24x7)