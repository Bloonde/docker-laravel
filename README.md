# Docker Laravel

Create image:

    $ docker build -t laravel .

Edited docker-compose.yml (optional except MYSQL_DATABASE and name_project)

- "MYSQL_DATABASE=homestead" //database mysql
- "MYSQL_USER=homestead" //user mysql
- "MYSQL_PASSWORD=secret" //password mysql
- "MYSQL_ROOT_PASSWORD=secret" //password root mysql
- "name_project:" //Name project

Start:

    $ docker-compose up
    
Edited .env project laravel:

- "DB_CONNECTION=mysql" //not edited
- "DB_HOST=mysql" //not edited
- "DB_PORT=3306" //not edited
- "DB_DATABASE=homestead" //MYSQL_DATABASE docker-compose.yml
- "DB_USERNAME=root" //MYSQL_USER docker-compose.yml
- "DB_PASSWORD=secret" //MYSQL_PASSWORD docker-compose.yml

Start bash container project laravel

    $ docker ps
    $ docker exec -it name_project bash //name_project for name command docker ps
    $ project // cd /var/www/html/project
    
    Commands: composer, artisan, git, etc...
  
After edited docker-compose.yml (after execute docker-compose up)

    $ docker-compose down
    $ docker-compose up
    
After edited php.ini

    $ apache reload
    
Alias

    $ project // cd /var/www/html/project
    $ apache reload // /etc/init.d/apache2 reload
    $ cda // composer dumpautoload
    $ lclear // php artisan config:clear && php artisan cache:clear && php artisan view:clear
    
