# Movie Fun!

## Build and Publish in a couple of steps
```
docker login
```
1password has the Education Dockerhub credentials

```
./do-build.sh
```

# step by step build and publish

Smoke Tests require server running on port 8080 by default.

## Build WAR ignoring Smoke Tests

```
$ mvn clean package -DskipTests -Dmaven.test.skip=true
```

# Dockerizing

## Pick your starting Dockerfile

## Buid the docker image
```
docker build -t pivotaleducation/moviefun-pks:2.0 .
```

## Run the docker image
```
docker run -p 8080:8080 -t pivotaleducation/moviefun-pks:2.0
```

# Verify it
```
open http://localhost:8080
```

## Run Smoke Tests against specific URL

```
MOVIE_FUN_URL=http://localhost:8080 mvn test
```

# Publish the docker image
```
docker login
```
1password has the Education Dockerhub credentials

```
docker push pivotaleducation/moviefun-pks:2.0
```

Make sure that is public on docker hub or it cannot be pulled.

# Clean up
```
docker container ls
```

Get the `CONTAINER ID` from the output

```
docker container stop <CONTAINER ID>
```

Remove the container
```
docker container rm <CONTAINER ID>
```

Remove the image
```
docker image rm pivotaleducation/moviefun-pks:2.0
```

# Kubernetes
```
pks login -a  https://api.pks.west.aws.pcfninja.com:9021 -u paladmin@pivotal.io -k
```
OR
```
pks login -a https://api.run.haas-208.pez.pivotal.io -k -u brad
```

```
pks get-creditials paldemo1
```
OR
```
pks get-creditials public
```

```
kubectl delete deployment moviefun-pks
```

```
kubectl run moviefun-pks --image=pivotaleducation/moviefun-pks:2.0 --replicas=1
```
OR
```
kubectl apply -f moviefun-pks.yaml
kubectl apply -f moviefun-pks-lb.yaml
```

```
kubectl get pods
```
get the pod name of the deployment

```
kubectl port-forward <pod name> 8080:8080
```
Not public but you have access to your application

[Movie Fun on PKS](http://localhost:8080/)

```
kubectl logs -f <pod name>
```

Public access will eventually work
`http://paltracker.pks.west.aws.pcfninja.com/`

Not very useful but its a shell on the container
kubectl exec -it <pod name> -- /bin/bash


ConfigMap - https://dzone.com/articles/configuring-spring-boot-on-kubernetes-with-configm
Secrets - https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/
https://dzone.com/articles/configuring-spring-boot-on-kubernetes-with-secrets

```
kubectl apply -f moviefun-pks-storageclass.yaml
kubectl apply -f moviefun-pks-persistentVolumeClaim.yaml
kubectl apply -f moviefun-pks-with-pv.yaml
kubectl apply -f moviefun-pks-lb.yaml
```
Alternative to `moviefun-pks-lb.yaml`
```
kubectl expose deployment moviefun-pks --type LoadBalancer --port 80 --target-port=8080
```