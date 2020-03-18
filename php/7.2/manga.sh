#!/bin/bash

function menu(){
	clear
	echo ""
	echo " 1. Instalar lo necesario"
	echo " 2. Descargar Laravel Project"
	echo " 3. Descargar Docker-Laravel"
	echo " 4. Descargar Docker-Angular"
	echo " 5. Descargar Docker-Vue"
	echo " 6. Añadir alias"
	echo " 7. Añadir host"
	echo " 0. Salir"
	echo ""
	read -p " Opción: " OPTION
	case "$OPTION" in
		1)
			clear
			install
		;;
		2)
			clear
			downloadLaravelProject
		;;
		3)
			clear
			downloadLaravelDocker
		;;
		4)
			clear
			downloadLaravelAngular
		;;
		5)
			clear
			downloadLaravelVue
		;;
		6)
			clear
			setAlias
		;;
		7)
			clear
			addHost
		;;
		0)
			clear
			exit
		;;
		*)
			clear
			echo " No funciona"
			read -p " Pulse [enter] para volver al menú"
			menu
		;;
	esac
}

function downloadLaravelProject(){
	clear
	read -p " Escriba el nombre del proyecto: " NAME_PROJECT
	read -p " Escriba la versión del proyecto [7.* / 6.* / 5.8.* / etc...]: " VERSION_PROJECT
    echo -e "\e[33m Warning --> Clonando Laravel... \e[39m"
	composer create-project --prefer-dist laravel/laravel "$NAME_PROJECT" "$VERSION_PROJECT"
	cd "$NAME_PROJECT"
	gedit .env
	downloadLaravelDocker
}

function downloadLaravelDocker(){
  clear
  echo -e "\e[33m Warning --> Clonando Docker... \e[39m"
  git clone https://github.com/Bloonde/docker-laravel.git
  cd docker-laravel
  echo -e "\e[33m Warning --> Borrando .git... \e[39m"
  sudo rm -r .git
  echo -e "\e[33m Warning --> Creando .env... \e[39m"
  cp .env.example .env
  gedit .env
  echo -e "\e[33m Warning --> Iniciando docker... \e[39m"
  ./start.sh
}

function downloadLaravelAngular(){
  clear
  git clone https://github.com/Bloonde/docker-angular.git
  cd docker-angular
  sudo rm -r .git
  cp .env.example .env
  gedit .env
  ./start.sh
}

function downloadLaravelVue(){
  clear
  git clone https://github.com/Bloonde/docker-vue.git
  cd docker-vue
  sudo rm -r .git
  cp .env.example .env
  gedit .env
  ./start.sh
}

function install(){
  clear
  echo -e "\e[33m Warning --> Instalando composer... \e[39m"
  installComposer
  clear
  echo -e "\e[33m Warning --> Instalando docker... \e[39m"
  installDocker
  clear
  echo -e "\e[94m Ok --> Todo instalado \e[39m"
  read -p " Pulse [enter] para reiniciar (RECOMENDADO) o [ctrl + c] para no reiniciar"
  reboot
}

function installComposer(){
  sudo apt update
  sudo apt install -y wget php-cli php-zip unzip curl
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
}

function installDocker(){
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $(whoami)
  sudo apt install -y docker-compose
}

function setAlias(){
	  if ! sudo cat ~/.bashrc | grep "alias manga='~/./manga.sh'" >> /dev/null
	  then
	    echo "alias manga='~/./manga.sh'" >> ~/.bashrc
	  fi
	  if ! sudo cat ~/.bashrc | grep "alias start='./start.sh'" >> /dev/null
	  then
	    echo "alias start='./start.sh'" >> ~/.bashrc
	  fi
	  if ! sudo cat ~/.bashrc | grep "alias stop='docker-compose down'" >> /dev/null
	  then
	    echo "alias stop='docker-compose down'" >> ~/.bashrc
	  fi
	  if ! sudo cat ~/.bashrc | grep "alias projects='cd ~/Projects'" >> /dev/null
	  then
	    echo "alias projects='cd ~/Projects'" >> ~/.bashrc
	  fi
    kill -9 $PPID
}

function addHost(){
    read -p "Host [example.test]: " HOST_NAME
	  if ! sudo cat /etc/hosts | grep "127.0.0.1 $HOST_NAME" >> /dev/null
	  then
	    echo "127.0.0.1 $HOST_NAME" | sudo tee -a /etc/hosts >> /dev/null
	  fi
}

function minimize(){
  gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
}

# shellcheck disable=SC2120
function laravelAbstract(){
    clear
    if [ -f "$FILE" ]
    then
        echo -e "\e[33m Warning --> Borrando app/User.php... \e[39m"
        sudo rm -r app/User.php
    fi
    sudo rm -r database/migrations
    echo -e "\e[33m Warning --> Borrando database/migrations... \e[39m"
    mkdir database/migrations
    echo -e "\e[33m Warning --> Creando database/migrations... \e[39m"
    AUX="0"
	  if ! sudo cat composer.json | grep '"bloondeweb/LaravelAbstractClass": "master"' >> /dev/null
	  then
	    COMPOSER=$(sed "$(($(cat composer.json | grep -n '"require": {' | cut -d ':' -f 1) + 1)) i         \"bloondeweb/LaravelAbstractClass\": \"master\"," composer.json)
	    echo -e "\e[33m Warning --> Añadiendo a composer.json... \e[39m"
	    echo "$COMPOSER" > composer.json
	  fi
	  if ! sudo cat composer.json | grep '"repositories": \[' >> /dev/null
	  then
	    AUX="1"
	    REPOSITORIES=$(sed "$(($(cat composer.json | grep -n '"require-dev": {' | cut -d ':' -f 1))) i     \"repositories\": [\n ]," composer.json)
	    echo -e "\e[33m Warning --> Añadiendo a composer.json... \e[39m"
	    echo "$REPOSITORIES" > composer.json
	  fi
	  if ! sudo cat composer.json | grep '"url": "https://github.com:/bloondeweb/LaravelAbstractClass.git"' >> /dev/null
	  then
	    if [ $AUX = "1" ]
	    then
	      REPO=$(sed "$(($(cat composer.json | grep -n '"repositories": \[' | cut -d ':' -f 1) + 1)) i         {\n              \"type\": \"vcs\",\n              \"url\": \"https://github.com:/bloondeweb/LaravelAbstractClass.git\"\n         }"  composer.json)
      else
	      REPO=$(sed "$(($(cat composer.json | grep -n '"repositories": \[' | cut -d ':' -f 1) + 1)) i         {\n              \"type\": \"vcs\",\n              \"url\": \"https://github.com:/bloondeweb/LaravelAbstractClass.git\"\n         },"  composer.json)
      fi
	    echo -e "\e[33m Warning --> Añadiendo a composer.json... \e[39m"
	    echo "$REPO" > composer.json
	  fi
	  echo -e "\e[33m Warning --> Actualizando composer... \e[39m"
	  composer update
	  if ! sudo cat composer.json | grep '"Bloonde\\\\ProjectGenerator\\\\\": "vendor/bloondeweb/LaravelAbstractClass/src"' >> /dev/null
	  then
	    PSR4=$(sed "$(($(cat composer.json | grep -n '"autoload": {' | cut -d ':' -f 1) + 2)) i             \"Bloonde\\\\\\\\ProjectGenerator\\\\\\\\\": \"vendor/bloondeweb/LaravelAbstractClass/src\"," composer.json)
	    echo -e "\e[33m Warning --> Añadiendo a composer.json... \e[39m"
	    echo "$PSR4" > composer.json
	  fi
	  if ! sudo cat config/app.php | grep 'Bloonde\\ProjectGenerator\\LaravelAbstractClassServiceProvider::class' >> /dev/null
	  then
	    APP=$(sed "$(($(cat config/app.php | grep -n "providers' => \[" | cut -d ':' -f 1) + 1)) i         Bloonde\\\\ProjectGenerator\\\\LaravelAbstractClassServiceProvider::class," config/app.php)
	    echo -e "\e[33m Warning --> Añadiendo a config/app.php... \e[39m"
	    echo "$APP" > config/app.php
	  fi
	  echo -e "\e[33m Warning --> Actualizando librerias... \e[39m"
	  composer dumpautoload
	  echo -e "\e[33m Warning --> Limpiando laravel... \e[39m"
	  php artisan config:clear && php artisan cache:clear
	  echo -e "\e[94m Ok --> Terminado \e[39m"
}

function userAndPrivilegies(){
    FILE=app/Autoload.php
    if [ -f "$FILE" ]
    then
    AUX="0"
	  if ! sudo cat composer.json | grep '"tymon/jwt-auth": "^0.5.12"' >> /dev/null
	  then
	    COMPOSER=$(sed "$(($(cat composer.json | grep -n '"require": {' | cut -d ':' -f 1) + 1)) i         \"tymon/jwt-auth\": \"^0.5.12\"," composer.json)
	    echo "$COMPOSER" > composer.json
	  fi
	  if ! sudo cat composer.json | grep '"bloondeweb/usersandprivileges": "master"' >> /dev/null
	  then
	    COMPOSER=$(sed "$(($(cat composer.json | grep -n '"require": {' | cut -d ':' -f 1) + 1)) i         \"bloondeweb/usersandprivileges\": \"master\"," composer.json)
	    echo "$COMPOSER" > composer.json
	  fi
	  if ! sudo cat composer.json | grep '"repositories": \[' >> /dev/null
	  then
	    AUX="1"
	    REPOSITORIES=$(sed "$(($(cat composer.json | grep -n '"require-dev": {' | cut -d ':' -f 1))) i     \"repositories\": [\n ]," composer.json)
	    echo "$REPOSITORIES" > composer.json
	  fi
	  if ! sudo cat composer.json | grep '"url": "https://github.com:/bloondeweb/usersandprivileges.git"' >> /dev/null
	  then
	    if [ $AUX = "1" ]
	    then
	      REPO=$(sed "$(($(cat composer.json | grep -n '"repositories": \[' | cut -d ':' -f 1) + 1)) i         {\n              \"type\": \"vcs\",\n              \"url\": \"https://github.com:/bloondeweb/usersandprivileges.git\"\n         }"  composer.json)
      else
	      REPO=$(sed "$(($(cat composer.json | grep -n '"repositories": \[' | cut -d ':' -f 1) + 1)) i         {\n              \"type\": \"vcs\",\n              \"url\": \"https://github.com:/bloondeweb/usersandprivileges.git\"\n         },"  composer.json)
      fi
	    echo "$REPO" > composer.json
	  fi
	  composer update
	  if ! sudo cat composer.json | grep '"Bloonde\\\\UsersAndPrivileges\\\\\": "vendor/bloondeweb/usersandprivileges/src"' >> /dev/null
	  then
	    PSR4=$(sed "$(($(cat composer.json | grep -n '"autoload": {' | cut -d ':' -f 1) + 2)) i             \"Bloonde\\\\\\\\UsersAndPrivileges\\\\\\\\\": \"vendor/bloondeweb/usersandprivileges/src\"," composer.json)
	    echo "$PSR4" > composer.json
	  fi
	  if ! sudo cat composer.json | grep '"Bloonde\\UsersAndPrivileges\\Database\\Seeds\\\": "vendor/bloondeweb/usersandprivileges/database/seeds/"' >> /dev/null
	  then
	    PSR4=$(sed "$(($(cat composer.json | grep -n '"autoload": {' | cut -d ':' -f 1) + 2)) i             \"Bloonde\\\\\\\\UsersAndPrivileges\\\\\\\\Database\\\\\\\\Seeds\\\\\\\\\": \"vendor/bloondeweb/usersandprivileges/database/seeds/\"," composer.json)
	    echo "$PSR4" > composer.json
	  fi
	  if ! sudo cat config/app.php | grep 'Bloonde\\UsersAndPrivileges\\UsersAndPrivilegesServiceProvider::class' >> /dev/null
	  then
	    APP=$(sed "$(($(cat config/app.php | grep -n "providers' => \[" | cut -d ':' -f 1) + 1)) i         Bloonde\\\\UsersAndPrivileges\\\\UsersAndPrivilegesServiceProvider::class," config/app.php)
	    echo "$APP" > config/app.php
	  fi
	  if ! sudo cat config/app.php | grep 'Tymon\\\\JWTAuth\\\\Providers\\\\JWTAuthServiceProvider::class' >> /dev/null
	  then
	    APP=$(sed "$(($(cat config/app.php | grep -n "providers' => \[" | cut -d ':' -f 1) + 1)) i         Tymon\\\\JWTAuth\\\\Providers\\\\JWTAuthServiceProvider::class," config/app.php)
	    echo "$APP" > config/app.php
	  fi
	  if ! sudo cat config/app.php | grep "Tymon\\\\JWTAuth\\\\Facades\\\\JWTAuth::class" >> /dev/null
	  then
	    ALIAS=$(sed "$(($(cat config/app.php | grep -n "'aliases' => \[" | cut -d ':' -f 1) + 1)) i         'JWTAuth' => Tymon\\\\JWTAuth\\\\Facades\\\\JWTAuth::class," config/app.php)
	    echo "$ALIAS" > config/app.php
	  fi
	  if ! sudo cat config/app.php | grep "Tymon\\\\JWTAuth\\\\Facades\\\\JWTFactory::class" >> /dev/null
	  then
	    ALIAS=$(sed "$(($(cat config/app.php | grep -n "'aliases' => \[" | cut -d ':' -f 1) + 1)) i         'JWTFactory' => Tymon\\\\JWTAuth\\\\Facades\\\\JWTFactory::class," config/app.php)
	    echo "$ALIAS" > config/app.php
	  fi
	  composer dumpautoload
	  php artisan config:clear && php artisan cache:clear
	  php artisan lvl:create_profile_helper
	  php artisan lvl:create_custom_check_privilege
	  if ! sudo cat app/Http/Kernel.php | grep "use App\\\\Http\\\\Middleware\\\\CustomCheckPrivilege;" >> /dev/null
	  then
	    USE=$(sed "$(($(cat app/Http/Kernel.php | grep -n "namespace App\\\\Http;" | cut -d ':' -f 1) + 2)) i use App\\\\Http\\\\Middleware\\\\CustomCheckPrivilege;" app/Http/Kernel.php)
	    echo "$USE" > app/Http/Kernel.php
	  fi
	  if ! sudo cat app/Http/Kernel.php | grep "use Bloonde\\\\UsersAndPrivileges\\\\Http\\\\Middleware\\\\CheckProfile;" >> /dev/null
	  then
	    USE=$(sed "$(($(cat app/Http/Kernel.php | grep -n "namespace App\\\\Http;" | cut -d ':' -f 1) + 2)) i use Bloonde\\\\UsersAndPrivileges\\\\Http\\\\Middleware\\\\CheckProfile;" app/Http/Kernel.php)
	    echo "$USE" > app/Http/Kernel.php
	  fi
	  if ! sudo cat app/Http/Kernel.php | grep "use Bloonde\\\\UsersAndPrivileges\\\\Middleware\\\\CheckAccountActivation;" >> /dev/null
	  then
	    USE=$(sed "$(($(cat app/Http/Kernel.php | grep -n "namespace App\\\\Http;" | cut -d ':' -f 1) + 2)) i use Bloonde\\\\UsersAndPrivileges\\\\Middleware\\\\CheckAccountActivation;" app/Http/Kernel.php)
	    echo "$USE" > app/Http/Kernel.php
	  fi
	  if ! sudo cat app/Http/Kernel.php | grep "checkAccountActivation" >> /dev/null
	  then
	    KERNEL=$(sed "$(($(cat app/Http/Kernel.php | grep -n "protected \$routeMiddleware = \[" | cut -d ':' -f 1) + 1)) i 'checkAccountActivation'   => CheckAccountActivation::class," app/Http/Kernel.php)
	    echo "$KERNEL" > app/Http/Kernel.php
	  fi
	  if ! sudo cat app/Http/Kernel.php | grep "checkPrivilege" >> /dev/null
	  then
	    KERNEL=$(sed "$(($(cat app/Http/Kernel.php | grep -n "protected \$routeMiddleware = \[" | cut -d ':' -f 1) + 1)) i 'checkPrivilege'   => CustomCheckPrivilege::class," app/Http/Kernel.php)
	    echo "$KERNEL" > app/Http/Kernel.php
	  fi
	  if ! sudo cat app/Http/Kernel.php | grep "checkProfile" >> /dev/null
	  then
	    KERNEL=$(sed "$(($(cat app/Http/Kernel.php | grep -n "protected \$routeMiddleware = \[" | cut -d ':' -f 1) + 1)) i 'checkProfile'   => CheckProfile::class," app/Http/Kernel.php)
	    echo "$KERNEL" > app/Http/Kernel.php
	  fi
	  if ! sudo cat routes/console.php | grep "init-database" >> /dev/null
	  then
	    echo "Artisan::command('init-database {withSeed}', function (\$withSeed = null){" >> routes/console.php
	    echo "  \$this->call('migrate', ['--path' => '/vendor/bloondeweb/usersandprivileges/database/migrations']);" >> routes/console.php
	    echo "  \$this->info('Migradas tablas del paquete de usuarios y privilegios');" >> routes/console.php
	    echo "  \$this->call('migrate');" >> routes/console.php
	    echo "  \$this->info('Migradas tablas del core');" >> routes/console.php
	    echo "  if(\$withSeed) {" >> routes/console.php
	    echo "      \$this->call('db:seed', ['--class' => 'Bloonde\UsersAndPrivileges\Database\Seeds\UserProfileTableSeeder']);" >> routes/console.php
	    echo "      \$this->call('db:seed', ['--class' => 'DatabaseSeeder']);" >> routes/console.php
	    echo "  }" >> routes/console.php
	    echo "});" >> routes/console.php
	  fi
	  php artisan config:clear && php artisan cache:clear
    else
        echo -e "\e[31m Error --> $FILE no existe, ejecute php artisan lvl:create_resource_files {resource} {model} {migration} antes de seguir\e[39m"
    fi
    exit
}

case "$1" in
	laravel)
		case "$2" in
			project)
				downloadLaravelProject
			;;
			docker)
				downloadLaravelDocker
			;;
            abstract)
              laravelAbstract
            ;;
            user)
              userAndPrivilegies
            ;;
		esac
	;;
  angular)
    downloadLaravelAngular
  ;;
  vue)
    downloadLaravelVue
  ;;
  install)
    install
  ;;
	menu)
		menu
	;;
	alias)
	  setAlias
	;;
	host)
	  addHost
	;;
	minimize)
	  minimize
	;;
	ssh)
		case "$2" in
			bloonde)
        case "$3" in
          mysql)
            ssh -N -L 3336:127.0.0.1:3306 root@167.71.73.40
          ;;
          *)
            ssh root@167.71.73.40
          ;;
        esac
			;;
		esac
	;;
	drive)
		case "$2" in
			install)
				sudo add-apt-repository ppa:alessandro-strada/ppa
				sudo apt-get install google-drive-ocamlfuse
				google-drive-ocamlfuse
				mkdir ~/GoogleDrive
			;;
			start)
				google-drive-ocamlfuse ~/GoogleDrive
			;;
			stop)
				fusermount -u ~/GoogleDrive
			;;
			restart)
				fusermount -u ~/GoogleDrive
				google-drive-ocamlfuse ~/GoogleDrive
			;;
		esac
	;;
  *)
    echo ""
    echo " manga laravel project -------------------- Descargar Laravel"
    echo " manga laravel docker --------------------- Descargar Laravel-Docker"
    echo " manga laravel abstract ------------------- Configurar proyecto para usar paquete Laravel Abstract"
    echo " manga laravel user ----------------------- Configurar proyecto para usar paquete User and Privilegies"
    echo " manga angular ---------------------------- Descargar Docker-Angular"
    echo " manga vue -------------------------------- Descargar Docker-Vue"
    echo " manga install ---------------------------- Instalar docker, docker-compose y composer"
    echo " manga alias ------------------------------ Añadir alias"
    echo " manga host ------------------------------- Añadir host"
    echo " manga minimize --------------------------- Minimizar hacienco click en dock"
    echo " manga drive [install/start/stop/restart] - Instalar/Montar/Desmontar/Reiniciar GoogleDrive"
    echo " manga ssh bloonde ------------------------ Iniciar conexión ssh con bloonde"
    echo " manga menu ------------------------------- Menú del Script"
    echo ""
    read -p " Pulse [enter] para salir "
  ;;
esac
