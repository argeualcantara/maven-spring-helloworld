FROM maven:3.8.1-jdk-11-slim

COPY ./target/helloworld-0.0.1-SNAPSHOT.jar /app/helloworld-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java",  "-jar", "/app/helloworld-0.0.1-SNAPSHOT.jar"]
