FROM openjdk:8-jre
ADD target/moviefun.war moviefun.war
EXPOSE 8080
ENTRYPOINT ["java","-jar","/moviefun.war"]