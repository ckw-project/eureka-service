# Stage 1: Build the application
FROM eclipse-temurin:17-jdk-ubi9-minimal AS builder

# Set working directory
WORKDIR /app

# Copy project files into the container
COPY . .

# Build the application
RUN ./mvnw clean package -DskipTests

# Stage 2: Create the runtime image
FROM eclipse-temurin:17-jre-ubi9-minimal

# Set working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/eureka-server-0.0.1-SNAPSHOT.jar app.jar

# Expose the Eureka Server port
EXPOSE 8010

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
