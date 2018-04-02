#!/bin/bash
rm -rf /root/projects
export OPENWHISK_HOME="${HOME}/openwhisk"
mkdir -p $OPENWHISK_HOME/bin
mkdir -p /root/projects/getting-started

wget https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-386.tgz
tar -zxf OpenWhisk_CLI-latest-linux-386.tgz -C $OPENWHISK_HOME/bin

export PATH="${OPENWHISK_HOME}/bin:${PATH}"

oc new-project faas --display-name="FaaS- Apache OpenWhisk"
oc adm policy add-role-to-user admin developer -n faas
oc process -f https://git.io/openwhisk-template | oc create -f -

./wait-for-ow-ready.sh

oc patch route openwhisk --namespace faas -p '{"spec":{"tls": {"insecureEdgeTerminationPolicy": "Allow"}}}'
AUTH_SECRET=$(oc get secret whisk.auth -o yaml | grep "system:" | awk '{print $2}' | base64 --decode)
wsk property set --auth $AUTH_SECRET --apihost $(oc get route/openwhisk --template="{{.spec.host}}")
wsk -i property get
wsk -i action list
