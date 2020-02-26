FROM debian:7.10

LABEL maintainer "miguelwill@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.debian.org/debian wheezy main contrib non-free" > /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --force-yes \
    debian-archive-keyring \
    curl unzip bzip2 \
    net-tools \
    wget && \
    apt-get clean


RUN apt-get update && \
    apt-get install -y --force-yes \
    net-tools vim rsyslog ca-certificates postfix \
    apache2 php5 php5-mysql php5-gd php5-imagick libapache2-mod-php5 php5-mcrypt mysql-client php5-memcache memcached php5-memcached php5-xcache php5-imap php-net-imap php-net-socket php-pear php5-mcrypt \
    rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#modsecurity
#RUN apt-get update && \
#    apt-get install -y --force-yes \
#    libapache2-modsecurity modsecurity-crs && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN mv -v /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
#RUN cp -vp /usr/share/modsecurity-crs/base_rules/* /etc/modsecurity/
#RUN a2enmod mod-security

RUN a2enmod ssl
RUN a2ensite default-ssl
RUN a2enmod rewrite




ENV TZ="America/Santiago" \
    SERVER_NAME="localhost" \
    APACHE_RUN_USER="www-data" \
    APACHE_RUN_GROUP="www-data" \
    APACHE_PID_FILE="/var/run/apache2.pid" \
    APACHE_RUN_DIR="/var/run/apache2" \
    APACHE_LOCK_DIR="/var/lock/apache2" \
    APACHE_LOG_DIR="/var/log/apache2" \
    APACHE_LOG_LEVEL="warn" \
    APACHE_CUSTOM_LOG_FILE="/proc/self/fd/1" \
    APACHE_ERROR_LOG_FILE="/proc/self/fd/2"

RUN mkdir -p /var/run/apache2 /var/lock/apache2

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/ssl_access.log

#Expose ports for services
EXPOSE 80/tcp 443/tcp


WORKDIR /

COPY main.sh /


ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]
