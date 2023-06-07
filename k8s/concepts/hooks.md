# hooks in k8s 

kubelet managed Containers can use the Container lifecycle hook framework to run code triggered by events during their management lifecycle.

## Container hooks 

- PostStart: This hook is executed immediately after a container is created. However, there is no guarantee that the hook will execute before the container ENTRYPOINT. No parameters are passed to the handler.

- PreStop: This hook is called immediately before a container is terminated due to an API request or management event such as a liveness/startup probe failure, preemption, resource contention and others.

## Hook handler implementations

- exec
- http 

# Demo 

Here’s an example that applies hook handlers to a container running the NGINX web server. The implementation of the Poststart hook is trivial—it writes a file containing the time it was fired. The Prestop hook is used to gracefully stop NGINX when the container’s about to terminate, allowing it to finish serving existing clients. As this may take some time, the pod’s termination grace period is set to thirty seconds. This gives the combination of the preStop hook and the regular container termination process up to thirty seconds to complete.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hooks-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hooks-demo
  minReadySeconds: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  template:
    metadata:
      labels:
        app: hooks-demo
    spec:
      containers:
        - name: hooks-demo
          image: nginx:1.25.0
          ports:
              - containerPort: 80
          resources:
            limits:
              cpu: "1"
              memory: "1Gi"
            requests:
              cpu: "500m"
              memory: "512Mi"
          lifecycle:
             postStart:
              exec:
                  command: ["/bin/sh", "-c", "date > /container-started.txt"]
             preStop:
              exec:
                  command: ["/bin/sh", "-c", "echo 'fidelis just stopped container' && /usr/sbin/nginx -s quit"]
      terminationGracePeriodSeconds: 60
```
