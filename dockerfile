# ---- Stage 1: Build the application ---
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the application (skip tests to speed up the build)
RUN mvn clean package -DskipTests

# ---- Stage 2: Create the runtime image ----
FROM eclipse-temurin:17-jre-alpine

# Set working directory in the container
WORKDIR /app

# Copy the jar file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
