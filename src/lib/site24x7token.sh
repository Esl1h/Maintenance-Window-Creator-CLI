#!/bin/bash
function getacesstoken {
curl -s https://accounts.zoho.com/oauth/v2/token \
        -X POST \
        -d "client_id=$CONFIG_site24x7_clientid" \
        -d "client_secret=$CONFIG_site24x7_clientsecret" \
        -d "refresh_token=$CONFIG_site24x7_refreshtoken"\
        -d "grant_type=refresh_token"
}