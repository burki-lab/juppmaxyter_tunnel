#!/bin/bash
# This script helps to copy the remote logfiles to local computer.
# Needs to be run after job started.

# (A) as a first step we load the yaml reader and read the
# config file (~/config.yml) into $config_<...>
cd $(dirname $0)

# clone yaml parsing script from github
YAML_PARSER="../yaml_reader/parse_yaml.sh"
[[ ! -f "$YAML_PARSER" ]] && ../yaml_reader/init.sh

# load it
. $YAML_PARSER
eval `parse_yaml ../config.yml "config_"`

# (B) we copy the logging directory
SERVERDIR=$config_server_outputdir
SERVER="${config_server_loginname}@${config_server_name}.${config_server_loginaddress}"
LOGDIR=$config_local_logdir

rm -r $LOGDIR
scp -r $SERVER:$SERVERDIR $LOGDIR

# (C) get the logfile over ssh and extract the IP
LOGFILE="$LOGDIR/`ls $LOGDIR | grep .log | tail -1`"
IP=`cat $LOGFILE | grep -o -m 1 "[[:alnum:]]*.${config_server_loginaddress}:[[:digit:]]*"`
LINE=`cat $LOGFILE | grep -o -m 1 "http://127.0.0.1:[[:digit:]]*.*"`
echo "Copy to browser: $LINE"

# (D) start the tunnel
LOCALPORT=$config_local_port
ssh -L $LOCALPORT:$IP $SERVER
