# Docker Laravel

Create image:

    $ docker build -t laravel-3 .

Edited docker-compose.yml (optional except MYSQL_DATABASE and name_project)

- "MYSQL_DATABASE=homestead" //database mysql
- "MYSQL_USER=homestead" //user mysql
- "MYSQL_PASSWORD=secret" //password mysql
- "MYSQL_ROOT_PASSWORD=secret" //password root mysql
- "name_project:" //Name project

Start:

    $ docker-compose up
    
Execute command:

    $ docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
    
    output:
    /docker_name_project_1 - 172.20.0.3
    /docker_database_1 - 172.20.0.2 //DB_HOST .env project laravel
    
Edited .env project laravel:

- "DB_CONNECTION=mysql" //not edited
- "DB_HOST=172.20.0.2" //ip command before
- "DB_PORT=3306" //not edited
- "DB_DATABASE=homestead" //MYSQL_DATABASE docker-compose.yml
- "DB_USERNAME=root" //MYSQL_USER docker-compose.yml
- "DB_PASSWORD=secret" //MYSQL_PASSWORD docker-compose.yml

Start bash container project laravel

    $ docker ps
    $ docker exec -it docker_name_project_1 bash //docker_name_project_1 for name command docker ps
    $ project // cd /var/www/html/project
    
    Commands: composer, artisan, git, etc...
  
After edited docker-compose.yml (after execute docker-compose up)

    $ docker-compose down
    $ docker-compose up
