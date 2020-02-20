alias 'project'='cd /var/www/html/project'

# make following folders accessible to apache
chgrp -R www-data /var/www/html/project/storage;
chgrp -R www-data /var/www/html/project/bootstrap/cache;
chmod -R 777 /var/www/html/project/storage;

#Launch apache in the foreground
#We do this in the forground so that Docker can watch
#the process to detect if it has crashed
. /etc/apache2/envvars

apache2 -DFOREGROUND;





