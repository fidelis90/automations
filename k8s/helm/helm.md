# Concepts of helm  

## Chart hooks 

Helm provides a hook mechanism to allow chart developers to intervene at certain points in a release's life cycle. For example, you can use hooks to:

- Load a ConfigMap or Secret during install before any other charts are loaded.

- Execute a Job to back up a database before installing a new chart, and then execute a second job after the upgrade in order to restore data.

- Run a Job before deleting a release to gracefully take a service out of rotation before removing it.

### Available hooks 

1. pre-install: Executes after templates are rendered, but before any resources are created in Kubernetes

2. post-install: Executes after all resources are loaded into Kubernetes

3. pre-delete: Executes on a deletion request before any resources are deleted from Kubernetes

4. post-delete: 	Executes on a deletion request after all of the release's resources have been deleted

5. pre-upgrade: Executes on an upgrade request after templates are rendered, but before any resources are updated

6. post-upgrade: Executes on an upgrade request after all resources have been upgraded

7. pre-rollback: Executes on a rollback request after templates are rendered, but before any resources are rolled back

8. post-rollback: Executes on a rollback request after all resources have been modified

9. test: 	Executes when the Helm test subcommand is invoked ( view test docs)

## Hooks and the Release Lifecycle

consider the lifecycle for a helm install. By default, the lifecycle looks like this:

1. User runs helm install foo
2. The Helm library install API is called
3. After some verification, the library renders the foo templates
4. The library loads the resulting resources into Kubernetes
5. The library returns the release object (and other data) to the client
6. The client exits

Helm defines two hooks for the install lifecycle: pre-install and post-install. If the developer of the foo chart implements both hooks, the lifecycle is altered like this:

1. User runs helm install foo
2. The Helm library install API is called
3. After some verification, the library renders the foo templates
4. The library prepares to execute the pre-install hooks (loading hook resources into Kubernetes)
5. The library sorts hooks by weight (assigning a weight of 0 by default), by resource kind and finally by name in ascending order.
6. The library waits until the hook is "Ready" (except for CRDs)
7. The library loads the resulting resources into Kubernetes. Note that if the --wait flag is set, the library will wait until all resources are in a ready state and will not run the post-install hook until they are ready.
8. The library executes the post-install hook (loading hook resources)
9. The library waits until the hook is "Ready"
10. The library returns the release object (and other data) to the client
11. The client exits

### What does it mean to wait until a hook is ready?

This depends on the resource declared in the hook. If the resource is a Job or Pod kind, Helm will wait until it successfully runs to completion. And if the hook fails, the release will fail. This is a blocking operation, so the Helm client will pause while the Job is run.

### Hook resources are not managed with corresponding releases

The resources that a hook creates are currently not tracked or managed as part of the release. 

#### Hook Delete Policies

These are annotations; 
> Syntax: **"helm.sh/hook-delete-policy": hook-succeeded**

- hook-succeeded: As mentioned earlier, this value indicates that the hook resource should be deleted automatically after it successfully executes.

- hook-failed: This value specifies that the hook resource should be deleted if it encounters a failure or error during execution. If the hook fails, Helm will remove the associated resource to clean up after the failed execution.

- before-hook-creation: With this value, Helm will delete any previously existing hook resources with the same name before creating the new one. This can be useful when you want to ensure a clean state before executing a hook.

- hook-rollback: When a rollback operation occurs, Helm will delete hook resources with this value to clean up any hooks that were executed during the failed operation.

- hook-succeeded-keep: This value instructs Helm to retain the hook resource even after it successfully executes. The resource will not be deleted automatically and will persist in the cluster.

- hook-failed-keep: Similarly, this value indicates that the hook resource should be preserved even if it encounters a failure during execution. Helm will not delete the resource automatically, allowing for further investigation or manual cleanup.

## Let's Demo Helm Hook 

1. Create demo helm chart
```
helm create demo
```

2. add the hook to the templates directory 

3. Run your helm install 

## Chart tests 

A chart contains a number of Kubernetes resources and components that work together. As a chart author, you may want to write some tests that validate that your chart works as expected when it is installed.
The job definition must contain the helm test hook annotation: helm.sh/hook: test

### Steps to Run a Test Suite on a Release

1. helm create demo 
2. find the test script in templates/tests/test-connection.yaml
3. helm install to create a release 
4. helm test $RELEASE_NAME 

> NOTE: A test is a Helm hook, so annotations like helm.sh/hook-weight and helm.sh/hook-delete-policy may be used with test resources.

## Helm flow controls

this gives ability to control the flow of a template's generation. 

- if/else for creating conditional blocks
- with to specify a scope
- range, which provides a "for each"-style loop

### if/else 

```
{{ if PIPELINE }}
  # Do something
{{ else if OTHER PIPELINE }}
  # Do something else
{{ else }}
  # Default case
{{ end }}
```
>> EXAMPLE 
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ .Values.favorite.drink | default "tea" | quote }}
  food: {{ .Values.favorite.food | upper | quote }}
  {{ if eq .Values.favorite.drink "coffee" }}
  mug: "true"
  {{ end }}
```



