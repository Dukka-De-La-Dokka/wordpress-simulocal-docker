#!/bin/bash

# This script has to be run everytime the new containers have been created
# Please execute this script if you encountered REST API related Error
# which is indicated at site health check page
# Please make sure docker containers are being up before executing scirpt
# If you executed this script consecutively, please remove all containers and create them again

docker exec -it -u root <wordpress_container_name> /bin/bash -c \
'echo -e "\nListen 8080\n" >> /etc/apache2/ports.conf'
docker exec -it -u root <wordpress_container_name> /bin/bash -c \
'echo -e "\n<VirtualHost *:*>\n</VirtualHost>\n" >> /etc/apache2/sites-available/000-default.conf'
docker compose restart
