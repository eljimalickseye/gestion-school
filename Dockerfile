FROM tomcat:10-jdk17

# Install necessary packages
RUN apt-get update && apt-get install -y tzdata && \
    rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=Africa/Dakar

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file as ROOT.war (déploiement à la racine)
COPY gestion_ecole.war /usr/local/tomcat/webapps/ROOT.war

# Create upload directory
RUN mkdir -p /var/lib/gestion_ecole/data && \
    chmod 777 /var/lib/gestion_ecole/data

# Set environment variables for the application
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/school_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Africa/Dakar
ENV SPRING_DATASOURCE_USERNAME=utilisateur_apiRest1
ENV SPRING_DATASOURCE_PASSWORD=Security@21
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update
ENV JWT_SECRET=404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970
ENV JWT_EXPIRATION=1800000
ENV BASE_URL_SERVER=http://vps120617.serveur-vps.net:8181/gestion_ecole
ENV BASE_URL_LOCAL=localhost:8181/gestion_ecole
ENV APP_UPLOAD_DIR=/var/lib/gestion_ecole/data
ENV server.port=8181

# Expose the application port
EXPOSE 8181

# Configure Tomcat to use port 8181
RUN sed -i 's/port="8080"/port="8181"/g' /usr/local/tomcat/conf/server.xml

CMD ["catalina.sh", "run"]