#!/usr/bin/env bash

set -x

BASEPATH=`dirname $(readlink -f ${BASH_SOURCE[0]})` && cd $BASEPATH
mkdir -p .ssh
ssh-keygen -t rsa -f .ssh/id_rsa
echo "=> cat .ssh/id_rsa.pub"
cat .ssh/id_rsa.pub
