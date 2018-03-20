# Delete Java Function

Having successfully created and updated a Java Function on to [Apache OpenWhisk](https://openwhisk.apache.org/) to [OpenShift](https://openshift.com), we will now see how to delete the Java Function that we created earlier.

**1. Delete Java function**

Lets now delete the function called **hello-openwhisk**:

``wsk -i action delete hello-openwhisk``{{execute}}

A successful delete of the function will show output like:

![Updated Action](../assets/ow_action_delete_result.png)

**3. Verify the delete**

``wsk -i action list | grep hello-openwhisk``{{execute}}

The above command should return no results./

# Congratulations

Congratulations you have now successfully delete the Java function and deployed the same on to OpenWhisk.