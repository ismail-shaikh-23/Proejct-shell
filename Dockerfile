# Stage 1: Build the application using Maven
FROM maven:3.8.3-openjdk-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project file (pom.xml) and the source code to the container
COPY .  .


# Run Maven to build the application and skip tests
RUN mvn clean install -DskipTests

# Stage 2: Run the application with OpenJDK 17
FROM openjdk:17-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar /app/expenseapp.jar

# Expose the port the app will run on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "/app/expenseapp.jar"]

