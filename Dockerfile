FROM perl:latest

RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-perl2 libcgi-pm-perl && \
    a2enmod cgi

WORKDIR /var/www/html

COPY app/legacy.pl /usr/lib/cgi-bin/legacy.pl
RUN chmod +x /usr/lib/cgi-bin/legacy.pl

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]