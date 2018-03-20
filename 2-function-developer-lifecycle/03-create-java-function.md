# Create Java Function

Having successfully deployed [Apache OpenWhisk](https://openwhisk.apache.org/) to [OpenShift](https://openshift.com), and [OpenWhisk CLI](https://github.com/apache/incubator-openwhisk-cli/releases/) now configured to work with the OpenWhisk, we will now write a simple Java function.


**1. Create Java function**

Java function could be created using the [Java Action Maven Archetype](https://github.com/apache/incubator-openwhisk-devtools/tree/master/java-action-archetype).  

``cd /root/projects``{{execute}}

Create a Java Function project called **hello-openwhisk**

``mvn archetype:generate -DarchetypeGroupId=org.apache.openwhisk.java -DarchetypeArtifactId=java-action-archetype -DarchetypeVersion=1.0-SNAPSHOT -DgroupId=com.example -DartifactId=hello-openwhisk``{{execute}}

Move to the project directory
``cd ~/projects/hello-openwhisk``{{execute}}

Click the link below to open pom.xml and update the **finalName** with value **${artifactId}** that makes us avoid long jar names during Function deployment on OpenWhisk:

``~/projects/hello-openwhisk/pom.xml``{{open}}

Lets open the Java source file **/root/projects/hello-openwhisk/src/main/java/com/example/FunctionApp.java**  to review its contents, click the link below to pent the source file on editor:

``~/projects/hello-openwhisk/src/main/java/com/example/FunctionApp.java``{{open}}

All OpenWhisk Java Function class should have **main** method with signature that takes `com.google.gson.JsonObject` as parameter and returns `com.google.gson.JsonObject` as response.

Build the project 
``mvn clean package``{{execute}}

**NOTE**: The Java Action Maven Archetype is not yet there in maven central, hence if you plan to use them in your local OpenWhisk environment you then need to build and install from sources.

**2. Deploy the function**

Lets now create the function say **hello-openwhisk** to OpenWhisk:

``wsk -i action create hello-openwhisk target/hello-openwhisk.jar --main com.example.FunctionApp``{{execute}}

When we create Java function the parameter **--main** is mandatory,  it defines which main Java class that needs to be called during OpenWhisk Action invocation.

Lets check if the function is created correctly:

``wsk -i action list | grep 'hello-openwhisk'``{{execute}}

The output of the command should show something like:

```sh
/whisk.system/hello-openwhisk                             private java
```

**3. Verify the function**

Having created the function **hello-openwhisk**, lets now verify the function.

**Unblocked invocation**

All OpenWhisk action invocations are `unblocked` by default.  Each action invocation will return an **activation id** which can be used to check the result later.

![Web Console Login](../assets/ow_action_with_activation_id.png)

The **activation id** can be used to  check the response using `wsk` CLI like:

```sh
wsk -i activation result <activation_id>
```

e.g. 

```sh
wsk -i activation result ffb2966350904356b29663509043566e
```

Lets now invoke our Java Function in unblocked manner:

``ACTIVATION_ID=$(wsk -i action invoke hello-openwhisk | awk '{print $6}')``{{execute}}

Lets check the result of the invocation:

``wsk -i activation result $ACTIVATION_ID``{{execute}}

You should see a result like:

```json
{
    "greetings": "Hello! Welcome to OpenWhisk"
}
```

**Blocked invocation**

We can also make the OpenWhisk action invocation to be synchronous but adding a `--result` parameter to `wsk` CLI command: 

``wsk -i action invoke hello-openwhisk --result``{{execute}}

Executing the above command should return us a JSON payload like:

```json
{
    "greetings": "Hello! Welcome to OpenWhisk"
}
```

# Congratulations

Congratulations you have now successfully developed a Java function and deployed the same on to OpenWhisk.   In next step we will see how to update the function and redeploy it.