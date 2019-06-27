# Movie Fun!

Smoke Tests require server running on port 8080 by default.

## Build WAR ignoring Smoke Tests

```
$ mvn clean package -DskipTests -Dmaven.test.skip=true
```

# Dockerizing

## Pick your starting Dockerfile
See the [tomitribe docker github](https://github.com/tomitribe/docker-tomee)

We are starting with:
```
https://raw.githubusercontent.com/tomitribe/docker-tomee/master/8-jre-7.0.2-webprofile/Dockerfile
```
and then adding instructions from the lab.

## Buid the docker image
```
docker build -t pivotaleducation/moviefun-pks:1.0 .
```

## Run the docker image
```
docker run -p 8080:8080 -t pivotaleducation/moviefun-pks:1.0
```

For remote debugging by intellij using debug port 5005:
```
docker run -p 5005:5005 -p 8080:8080 -t pivotaleducation/moviefun-pks:1.0
```

# Verify it
```
open http://localhost:8080/moviefun
```

## Run Smoke Tests against specific URL

```
MOVIE_FUN_URL=http://localhost:8080/moviefun mvn test
```

# Publish the docker image
```
docker login
```
1password has the Education Dockerhub credentials

```
docker push pivotaleducation/moviefun-pks:1.0
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
docker image rm pivotaleducation/moviefun-pks:1.0
```

# Kubernetes
```
pks login -a  https://api.pks.west.aws.pcfninja.com:9021 -u paladmin@pivotal.io -k
```

```
pks get-credentials paldemo1
```

```
kubectl delete deployment moviefun-pks-bcd
```
```
kubectl run moviefun-pks-bcd --image=pivotaleducation/moviefun-pks:1.0 --replicas=1
```

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

[Movie Fun on PKS](http://localhost:8080/moviefun)

```
kubectl logs -f <pod name>
```

Public access will eventually work
`http://paltracker.pks.west.aws.pcfninja.com/moviefun`

Not very useful but its a shell on the container
kubectl exec -it <pod name> -- /bin/bash