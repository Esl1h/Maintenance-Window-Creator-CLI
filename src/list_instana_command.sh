function listinstana {
    curl -s --compressed --request GET \
    --url https://xxxxxxxx.instana.io/api/settings/maintenance \
    --header "authorization: apiToken $CONFIG_instana_apitoken"
}

jq '.' <(listinstana)