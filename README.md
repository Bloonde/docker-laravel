# Docker Laravel

Create .env

    $ cp .env.example .env

Edit .env

    -PROJECT_NAME=project_name
    -IMAGE_NAME=php // not edited
    -TAG_IMAGE=7.1 // 7.1 / 7.2 / 7.3

Start:

    $ ./start.sh
    
Run container

    $ docker exec -it project_name bash
    $ su docker
    
Alias

    $ project // cd /var/www/html/project
    $ apache reload // /etc/init.d/apache2 reload
    $ cda // composer dumpautoload
    $ lclear // php artisan config:clear && php artisan cache:clear && php artisan view:clear
    
