# Update Java Function

Having successfully developed and deployed a Java Function on to [Apache OpenWhisk](https://openwhisk.apache.org/) to [OpenShift](https://openshift.com), we will now update the Java function we wrote earlier step and redeploy it on to OpenWhisk.

**1. Update Java function**

Lets open the Java source file **/root/projects/hello-openwhisk/src/main/java/com/example/FunctionApp.java**

``/root/projects/hello-openwhisk/src/main/java/com/example/FunctionApp.java``{{open}}

Once the created file is opened in the editor, you can then copy the content below into the file (or use the `Copy to editor` button):

<pre class="file" data-filename="/root/projects/hello-openwhisk/src/main/java/com/example/FunctionApp.java" data-target="replace">
package com.example;

import com.google.gson.JsonObject;

/**
 * Hello FunctionApp
 */
public class FunctionApp {
  public static JsonObject main(JsonObject args) {
    JsonObject response = new JsonObject();
    response.addProperty("greetings", "Hello! Welcome to OpenWhisk on OpenShift");
    return response;
  }
}
</pre>

**2. Update Java function Test Class**

Since we have updated the Java Source we also need to update the test class as well, let's open the Java Test source file **/root/projects/hello-openwhisk/src/test/java/com/example/FunctionAppTest.java**

``/root/projects/hello-openwhisk/src/test/java/com/example/FunctionAppTest.java``{{open}}

Once the file is opened in the editor, you can then copy the content below into the file (or use the `Copy to editor` button):

<pre class="file" data-filename="/root/projects/hello-openwhisk/src/test/java/com/example/FunctionAppTest.java" data-target="replace">
package com.example;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import com.google.gson.JsonObject;

import org.junit.Test;

/**
 * Unit test for simple function.
 */
public class FunctionAppTest {
  @Test
  public void testFunction() {
    JsonObject args = new JsonObject();
    JsonObject response = FunctionApp.main(args);
    assertNotNull(response);
    String greetings = response.getAsJsonPrimitive("greetings").getAsString();
    assertNotNull(greetings);
    assertEquals("Hello! Welcome to OpenWhisk on OpenShift", greetings);
  }
}
</pre>

Finally rebuild the project 

``mvn clean package``{{execute}}

**2. Deploy the function**

Lets now update the function called **hello-openwhisk**:

``wsk -i action update hello-openwhisk target/hello-openwhisk.jar --main com.example.FunctionApp``{{execute}}

If you have noticed we are using `update` as part of `wsk` CLI action command to update the function with latest code.

A successful update of the function will show output like:

![Updated Action](../assets/ow_action_update_result.png)

**3. Verify the update**

Having created the function **hello-openwhisk**, lets now verify the update.

**Unblocked invocation**

All OpenWhisk action invocations are `unblocked` by default.  Each action invocation will return an **activation id** which can be used to check the result later.

![Action Activation ID](../assets/ow_action_with_activation_id.png)

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

You should now see a result like:

```json
{
    "greetings": "Hello! Welcome to OpenWhisk on OpenShift"
}
```

**Blocked invocation**

We can also make the OpenWhisk action invocation to be synchronous but adding a `--result` parameter to `wsk` CLI command: 

``wsk -i action invoke hello-openwhisk --result``{{execute}}

Executing the above command should return us a JSON payload like:

```json
{
    "greetings": "Hello! Welcome to OpenWhisk on OpenShift"
}
```

# Congratulations

Congratulations you have now successfully updated the Java function and deployed the same on to OpenWhisk.   In next step we will see how to delete the function.