# Apache2 with Mod-security on Debian7
Apache2 over Debian 7 with PHP 5.4.45 and Mod-security

[![Docker Pulls](https://img.shields.io/docker/pulls/miguelwill/debian7-apache-modsec.svg?style=plastic)](https://hub.docker.com/r/miguelwill/debian7-apache-modsec/)

# Description
debian7 image with apache2, PHP 5.4.45 and Mod-security
ready to work with old, unupdated sites, such as joomla 2.5 for example

ready to work with http (TCP/80) and https (TCP/443) connections
the certificate can be loaded into an external load balancer (such as nginx) so that you do not need to replace the default certificate used in apache2

# Configuration
you only need to configure the database access data, and the files must be copied to the path of the loaded volume in /var/www
you have mysql-client to import a mysql database backup into the "db" server from the container console

these parameters are also defined in docker-compose.yml file

# Add Stack with config
  * download files from https://github.com/miguelwill/debian7-apache-php
  * edit docker-compose.yml file editing db autentication parameters
  * run for deploy stack : docker stack deploy -c docker-compose.yml debian7-apache2
  * waith for db initialization



# Volume

  * '/var/www' - "load php and html files for your old website"

# Variables

  * 'TZ' - "time zone"
  * 'RELAY_HOST' - "relayhost for postfix, default is empty"
