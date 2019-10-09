FROM maven:3.6-jdk-8 as maven
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn clean package -DskipTests

EXPOSE 8080
FROM openjdk:8u171-jre-alpine
WORKDIR /gateway
COPY --from=maven target/gateway-0.0.1-SNAPSHOT.jar ./gateway.jar
CMD ["java", "-jar", "./gateway.jar"]
