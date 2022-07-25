## Maintenance Window Creator - CLI

NOTE: This is an under construction project created primarily for testing the Bashly framework and some bash/shell script regex exercises.

This CLI can create/list/delete a maintenance window in our alert systems, it's working on Site24x7, New Relic, Zabbix and Instana.




### Proposal

To be used in a CD pipeline (before starting the deployment) to create a maintenance window and not generate false-positive alerts from the applications.

Written using the bashly framework (in ruby) which allows you to use bash/shell script to create CLIs - https://bashly.dannyb.co/.


In the environment are used some different monitoring systems, the goal with this CLI is to identify by regex in which of the systems there is monitoring of the app in delivery and perform the creation of the maintenance window.

### Using

```
Usage:
  maintenance-window [command]
  maintenance-window [command] --help | -h
  maintenance-window --version | -v

Commands:
  create   commands to create a maintenance window
  delete   commands to delete a maintenance window
  list     commands to list maintenance windows
```

Ex.:

```
./maintenance-window create instana APP-NAME 26-12-2022_20:00 26-12-2022_21:30

./maintenance-window list instana
```

The timestamp needs to be in this format: YYYY-MM-DD_HH:MM


## Install

You don't need clone this repo!

Just copy to your local machine the files on root directory only:

- `maintenance-window       - to execute`
- `API.list                 - list of APIs to create multiples window manintenance from file`
- `config.yml               - configs with tokens from Monitoring Systems, hooks...`


Dont need the src folder and the others files.

## requirements to use:
If running in MacOS, install `gdate` (`brew install coreutils`)

Install `jq` (command line processor to json)

and bash, curl, cut, sed and awk... it's only ;-)



## requirements to develop:
Ruby >= 3.0.1

This API is develop over a Framework called "bashly" (it's a gem ruby, `gem install bashly`)

## TO-DO:

- Instana
    - [x] list
    - [x] create
    - [ ] delete
    - [ ] create multiples from file (Instana cant make a recurrent window maintenance), run cronjob everyday?

- Site24x7
    - [x] list
    - [x] create
    - [ ] delete
    - [ ] create/edit (add new monitor to) a recurrent maintenance window from file

- Zabbix
    - [x] list
    - [x] create
    - [ ] delete

- New Relic
    - [ ] list
    - [ ] create
    - [ ] delete

- API
    - [ ] identify OS running and change commands (ex.: `gdate` to `date`)
    - [ ] send alert to slack with: API, Date/time and URL
    - [ ] integrate to Vault (remove the config.yml)
    - [ ] arguments and flags validation (sanitize)
    - [ ] add parameter 'comment' (description) to insert on creation
    - [ ] create from a list file
    - [ ] search and create in all system who the argument SERVICE_NAME match (search on alert system and create)
