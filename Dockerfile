FROM eclipse-temurin:17-jdk-alpine

# Install necessary packages
RUN apk add --no-cache tzdata curl

# Set timezone
ENV TZ=Africa/Dakar

# Create application directory
WORKDIR /app

# Copy the WAR file
COPY gestion_ecole.war /app/gestion_ecole.war

# Create upload directory with proper permissions
RUN mkdir -p /var/lib/gestion_ecole/data

# Expose the application port
EXPOSE 8181

# Run the application with Spring Boot WarLauncher
ENTRYPOINT ["java", "-jar", "/app/gestion_ecole.war"]