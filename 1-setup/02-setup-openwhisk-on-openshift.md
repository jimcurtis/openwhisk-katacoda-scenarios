# Setup Apache OpenWhisk on OpenShift

Having prepared the [OpenShift Container Platform](https://openshift.com]) environment to deploy [Apache OpenWhisk](https://openwhisk.apache.org/), in this scenario we will deploy [Apache OpenWhisk](https://openwhisk.apache.org/) to the [OpenShift Container Platform](https://openshift.com]).

**1.Deploy OpenWhisk**

Make sure we are in `faas` project:

``oc project -q``{{execute}}

Deploy OpenWhisk on to OpenShift:

``oc process -f https://git.io/openwhisk-template | oc create -f -``{{execute}}

**2. Wait for sometime to check Pods Deployed**

The previous step takes a bit of time to get ready as [Apache OpenWhisk](https://openwhisk.apache.org/) has bunch of applications to be deployed, you can watch the status via the following command:

``oc logs -f controller-0 -n faas | grep "invoker status changed"``{{execute}}

or

You can also see the status via OpenShift Console:

![OpenShift Console Tab](../assets/openshift-console-tab.png) 

by navigating to **FaaS- Apache OpenWhisk** project.  Successful **controller** deployment should look like:

![OpenWhisk Controller](../assets/ow_controller_up.png)

**IMPORTANT**

Please proceed to next step if and only if the **controller** is ready.

**3. Edit OpenWhisk Ngnix Route TLS**
TODO: update to a better description

By default the OpenWhisk nginx route is configured to do "Redirect" for edge termination, in Katacoda
all the requests are secured hence we need to modify nginx route **openwhisk** insecureEdgeTerminationPolicy to "Allow"

``oc patch route openwhisk --namespace faas -p '{"spec":{"tls": {"insecureEdgeTerminationPolicy": "Allow"}}}'``{{execute}}

**4. Configure OpenWhisk CLI**

Get the default authentication and authorization credentials:

``AUTH_SECRET=$(oc get secret whisk.auth -o yaml | grep "system:" | awk '{print $2}' | base64 --decode)``{{execute}}

Set OpenWhisk CLI with authentication and API Host:

``wsk property set --auth $AUTH_SECRET --apihost $(oc get route/openwhisk --template="{{.spec.host}}")``{{execute}}

You can verify the settings via the command:

``wsk property get``{{execute}}

**5. Verify OpenWhisk CLI setup**

``wsk -i action list``{{execute}}

Successful execution of the above command should display output like below:

![OpenWhisk Default Catalog](../assets/ow_catalog_actions.png)

## Congratulations

You have now deployed [Apache OpenWhisk](https://openwhisk.apache.org/) to the [OpenShift Container Platform](https://openshift.com]). 

In next step of this scenario, we will write a simple JavaScript function, deploy it to OpenWhisk and invoke the same to verify that we are in good shape to continue our FaaS journey.