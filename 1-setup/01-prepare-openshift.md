# Introduction

[OpenShift Container Platform]
**Red Hat OpenShift Container Platform** is based on **Kubernetes** which is probably the most used Orchestrator for containers running in production. **OpenShift** is currently the only container platform based on Kuberenetes that offers multitenancy. This means that developers can have their own personal, isolated projects to test and verify application before committing to a shared code repository.

[Apache OpenWhisk(Incubating)]
**Apache OpenWhisk(Incubating)** is a [serverless](https://openwhisk.apache.org/serverless), open source cloud platform
that executes functions in response to events in any scale.

**2. Create project**

Let's create a project that you will use to house the [Apache OpenWhisk](https://openwhisk.apache.org/). 

``oc new-project faas --display-name="FaaS- Apache OpenWhisk"``{{execute}}

**3. Add developer as admin to `faas` project**

Since we will be using the user called `developer` throught this scenario it will be ideal to add `admin` role to the user `developer` to peform required tasks without switching user.

``oc adm policy add-role-to-user admin developer -n faas``{{execute}}

**4. Open the OpenShift Web Console**

OpenShift ships with a web-based console that will allow users to
perform various tasks via a browser. To get a feel for how the web console
works, click on the "OpenShift Console" tab next to the "Local Web Browser" tab.

![OpenShift Console Tab](../assets/openshift-console-tab.png)

The first screen you will see is the authentication screen. Enter your username and password and 
then login, the default credentials is `developer/developer`:

![Web Console Login](../assets/login.png)

After you have authenticated to the web console, you will be presented with a list of projects that your user has permission to view.

![Web Console Projects](../assets/projects.png)

Click on your new project name to be taken to the project overview page which will list all of the routes, services, deployments, and pods that you have created as part of your project:

![Web Console Overview](../assets/overview.png)

There's nothing there now, but that's about to change.


## Congratulations

You have now prepared OpenShift environment for deploying ApacheOpenWhisk. 

In next step of this scenario, we will deploy [Apache OpenWhisk](https://openwhisk.apache.org/) to the [OpenShift Container Platform](https://openshift.com]).