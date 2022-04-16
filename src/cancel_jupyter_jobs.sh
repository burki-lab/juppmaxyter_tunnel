#!/bin/bash
# This script helps to cancel all current jupyter jobs on server.
# Nice to run when jupyterlab is not needed for some times (e.g. 5+ hours).
# Save compuation time!
# Attention: This script also deletes the log file of all cancelled jobs!

# (A) as a first step we load the yaml reader and read the
# config file (~/config.yml) into $config_<...>
cd $(dirname $0)

# clone yaml parsing script from github
YAML_PARSER="../yaml_reader/parse_yaml.sh"
[[ ! -f "$YAML_PARSER" ]] && ../yaml_reader/init.sh

# load it
. $YAML_PARSER
eval `parse_yaml ../config.yml "config_"`

# (B) we load the user name and log dir into variables
USER="${config_server_loginname}"
LOGDIR="${config_server_outputdir}"
JOBNAME="jupyter"

# (C) cancel all jupyter jobs and remove their log files.
for JOB in `jobinfo -u $USER | grep $JOBNAME | awk '{ print $1 }'`
do
	LOGFILE="$LOGDIR/${JOB}.log"
	scancel $JOB
	rm $LOGFILE
done

echo "All running Jupyter jobs were cancelled and their logs removed."

