FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y language-pack-en-base
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y apache2 php7.1 libapache2-mod-php7.1 php7.0-cli php7.1-common php7.1-mbstring php7.1-intl php7.1-xml php7.1-mysql php7.1-mcrypt curl php7.1-curl zip unzip php-zip wget git nano p7zip-full php-imagick

#Install NodeJS
RUN apt-get install -y nodejs npm

#install composer, which is dependency manager for laravel
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#restart apache server and enable url rewrite mode
RUN service apache2 stop && a2enmod rewrite

#add virtual host configuration of the site
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN useradd -rm -d /home/docker -s /bin/bash -g root -G sudo -u 1000 docker
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 777 /root/entrypoint.sh
RUN echo 'alias project="cd /var/www/html"' >> /home/docker/.bashrc
RUN echo 'alias "apache"="/etc/init.d/apache2"' >> /home/docker/.bashrc
RUN echo 'alias "cda"="composer dumpautoload"' >> /home/docker/.bashrc
RUN echo 'alias "lclear"="php artisan config:clear && php artisan cache:clear && php artisan view:clear"' >> /home/docker/.bashrc
ENTRYPOINT /root/entrypoint.sh

EXPOSE 80
EXPOSE 3306
