# Setup Apache OpenWhisk on OpenShift

**1.Deploy OpenWhisk**

Deploy OpenWhisk on to OpenShift:

``oc process -f https://git.io/openwhisk-template | oc create -f -``{{execute}}

**2. Wait for sometime to check Pods Deployed**

``oc logs -f controller-0 -n faas | grep "invoker status changed"``{{execute}}

**3. Configure OpenWhisk CLI**

Get the default authentication and authorization credentials:

``AUTH_SECRET=$(oc get secret whisk.auth -o yaml | grep "system:" | awk '{print $2}' | base64 --decode)``{{execute}}

Set OpenWhisk CLI with secret and API Host:

``wsk property set --auth $AUTH_SECRET --apihost $(oc get route/openwhisk --template="{{.spec.host}}")``{{execute}}

**3. Verify OpenWhisk CLI setup**

``wsk -i action list``{{execute}}