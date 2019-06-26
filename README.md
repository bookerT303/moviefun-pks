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
https://github.com/tomitribe/docker-tomee/blob/master/8-jre-7.1.0-plus/Dockerfile
```
and then adding instructions from the lab.

## Buid the docker image
```
docker build -t bdavidson/moviefun-pks:1.0 .
```

## Run the docker image
```
docker run -p 8080:8080 -t bdavidson/moviefun-pks:1.0
```

# Verify it
```
open http://localhost:8080/moviefun
```

## Run Smoke Tests against specific URL

```
MOVIE_FUN_URL=http://localhost:8080/moviefun mvn test
```

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
