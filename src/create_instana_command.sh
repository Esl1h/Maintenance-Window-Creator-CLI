# mapfile APIS_ARRAY <API.list
# #echo "${APIS_ARRAY[@]}"
# #printf "${APIS_ARRAY[@]}"
# #printf "${APIS_ARRAY[*]}"

# for api in "${APIS_ARRAY[@]}"; do
#     CLEANED="${api%$'\n'}"
#     echo "${CLEANED}" testing.... 
# done

# validar se houver gdate no host (mac) usa, caso não, date (gnu).
# gdate -d '06/12/2012 07:21:22' + "%s"
#all:
SERVICE=$(echo ${args[SERVICE_NAME]})
START_DATE=$(echo ${args[START_TIME]})
START_WINDOW=${START_DATE/_/T}
START_EPOCH=$(gdate --date="$START_WINDOW" +%s)
END_DATE=$(echo ${args[END_TIME]})
END_WINDOW=${END_DATE/_/T}
END_EPOCH=$(gdate --date="$END_WINDOW" +%s)

function generateid {
    MAINTENANCEID=$(echo $RANDOM)
}

generateid

DATAINSTANA='{
        "id": "'"$MAINTENANCEID"'",
        "name": "testing creation",
        "query": "entity.service.name='"$SERVICE"'",
        "windows": [
        {
            "end": '"$END_EPOCH"'00,
            "id": "'"$MAINTENANCEID"'",
            "start": '"$START_EPOCH"'00
        }
        ]
    }'

function createmaintenancewindowinstana {
    curl --compressed -s --request PUT \
    --url https://apm-easynvest.instana.io/api/settings/maintenance/$MAINTENANCEID \
    -H "Content-Type: application/json; charset=utf-8" \
    --header "authorization: apiToken $CONFIG_instana_apitoken" \
        --data "$DATAINSTANA"
}
jq '.' <(createmaintenancewindowinstana)

