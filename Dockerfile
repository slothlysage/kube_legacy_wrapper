FROM perl:latest

# Install Apache and CGI dependencies, and add non-root user
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-perl2 libcgi-pm-perl && \
    a2enmod cgi && \
    adduser --disabled-password --gecos "" slothuser && \
    chown -R slothuser /usr/lib/cgi-bin /var/log/apache2 /var/lock/apache2 /var/run/apache2

# Copy CGI script and set permissions
COPY ../app/legacy.pl /usr/lib/cgi-bin/legacy.pl
RUN chmod +x /usr/lib/cgi-bin/legacy.pl && \
    chown -R slothuser /usr/lib/cgi-bin

# Change Apache's default port to 8080
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf && \
    sed -i 's/:80/:8080/g' /etc/apache2/sites-available/000-default.conf && \
    chown -R slothuser /etc/apache2

# Switch to non-root user
USER slothuser

# Expose Apache's new port
EXPOSE 8080

# Run Apache with a config override to use port 8080
CMD ["apachectl", "-D", "FOREGROUND"]