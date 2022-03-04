#!/bin/bash
# we load the executive file from a wonderful yaml parser

PARSE_FILE="parse_yaml.sh"

git clone https://gist.github.com/8665367.git

cd $(dirname $0)
[[ ! -f "$PARSE_FILE" ]]
mv ../8665367/$PARSE_FILE .
rm -fr ../8665367
chmod +x $PARSE_FILE
