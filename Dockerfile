# Use an official OpenJDK runtime with Maven pre-installed
FROM maven:3.8.6-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy project files to container
COPY . .

# Build the application
RUN mvn clean package

# Use a smaller image for running the app
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
