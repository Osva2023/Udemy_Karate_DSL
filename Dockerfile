FROM maven:3.9-eclipse-temurin-17

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app

COPY ./src/test/java /usr/src/app/src/test/java

CMD mvn test
