# Build stage: Build the application using JDK 21 and the Maven Wrapper
FROM eclipse-temurin:21-jdk AS builder

# Set the working directory inside the builder container
WORKDIR /app

# Copy Maven wrapper files and pom.xml first to leverage Docker layer caching
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Make the Maven wrapper script executable inside the container
RUN chmod +x mvnw

# Resolve dependencies offline to speed up subsequent builds
RUN ./mvnw dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the executable package
RUN ./mvnw clean package -DskipTests

# Runtime stage: Prepare the final minimal JRE runtime image
FROM eclipse-temurin:21-jre

# Set the working directory for execution
WORKDIR /app

# Copy the generated executable JAR from the builder stage
# Uses wildcard to avoid hardcoding the jar name/version
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Execute the application
ENTRYPOINT ["java", "-jar", "app.jar"]
