# Docker Laravel

Create .env

    $ cd docer-laravel
    $ cp .env.example .env

Edit .env (Docker-Laravel)

    -PROJECT_NAME=project_name
    -IMAGE_NAME=php // Not edited
    -TAG_IMAGE=7.1 // 7.1 / 7.2 / 7.3
    
Edit .env (Project)

    -DB_CONNECTION=mysql // Not edited
    -DB_HOST=mysql
    -DB_PORT=3306 //Not edited
    -DB_DATABASE=name_database
    -DB_USERNAME=root
    -DB_PASSWORD=secret

Start:

    $ cd docker-laravel
    $ ./start.sh
    
Run container and composer project

    $ docker exec -it project_name bash
    $ su docker
    $ project
    $ composer update
    
Alias

    $ project // cd /var/www/html/project
    $ apache reload // /etc/init.d/apache2 reload
    $ cu // composer update
    $ cda // composer dumpautoload
    $ lclear // php artisan config:clear && php artisan cache:clear && php artisan view:clear
    
