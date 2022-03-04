#!/bin/bash


# (A) as a first step we load the yaml reader and read the
# config file (~/config.yml) into $config_<...>
cd $(dirname $0)

# clone yaml parsing script from github
YAML_PARSER="../yaml_reader/parse_yaml.sh"
[[ ! -f "$YAML_PARSER" ]] && ../yaml_reader/init.sh

# load it
. $YAML_PARSER
eval `parse_yaml ../config.yml "config_"`


# (B) we load the input variables and commands
# jobname is always jupyter to enable simple cancel
JOBNAME="jupyter"

# cores, project and server are found in the config file
CORE_TYPE=$config_server_coretype
NUM_CORES=$config_server_numcores
PROJECT=$config_server_project
SERVER=$config_server_name

# jobinfo
DURATION=$config_server_duration
LOGFILE="$config_server_outputdir/@A.log"

# mail info
MAIL_ADD=$config_mail_address
MAIL_TYPE=$config_mail_type


# (C) building the main command 
# jupyter connection settings
IP=$config_connection_ip
PORT=$config_connection_port

# assemble jupy command
CMD="jupyter lab --no-browser --ip=$IP --port=$PORT"


# (D) finally submit the job

echo "sbatch -J $JOBNAME -A $PROJECT -M $SERVER -p $CORE_TYPE -n $NUM_CORES -t $DURATION -o $LOGFILE --mail-user $MAIL_ADD --mail-type $MAIL_TYPE $CMD"
