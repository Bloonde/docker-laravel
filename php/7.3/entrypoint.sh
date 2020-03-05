#!/bin/bash
PROJECT_NAME=`cat /root/.env | grep PROJECT_NAME | cut -d "=" -f2`
chgrp -R www-data /var/www/html/$PROJECT_NAME/storage
chgrp -R www-data /var/www/html/$PROJECT_NAME/bootstrap
chmod -R 777 /var/www/html/$PROJECT_NAME/storage
chmod -R 777 /var/www/html/$PROJECT_NAME/bootstrap
echo "alias project=\"cd /var/www/html/$PROJECT_NAME\"" >> /home/docker/.bashrc
. /etc/apache2/envvars
apache2 -DFOREGROUND
