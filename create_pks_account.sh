#!/usr/bin/env bash

set -e

if [[ $# != 3 ]]
then
    echo -e "\nusage:\n\n$0 USERNAME EMAIL PASSWORD\n"
    exit 1
fi

ssh_user=ubuntu
ssh_host=opsmgr-02.haas-208.pez.pivotal.io
uaa_api_url=https://api.run.haas-208.pez.pivotal.io:8443

username=$1
email=$2
password=$3

read -s -p $'PKS UAA Management Admin Client Secret:\n' uaa_client_secret

ssh $ssh_user@$ssh_host <<-ENDSSH
  echo "username: $uaa_client_secret"
  uaac target $uaa_api_url
  uaac token client get admin -s $uaa_client_secret
  uaac user add $username --email $email -p $password
  uaac member add pks.clusters.admin $username
ENDSSH

