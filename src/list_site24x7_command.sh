TOKEN=$(getacesstoken | cut -d "\"" -f 4)

function listsite24x7 {
    curl -s https://www.site24x7.com/api/maintenance \
    -H "Authorization: Zoho-oauthtoken $TOKEN"
}

jq '.' <(listsite24x7)