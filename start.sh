#!/bin/bash
PHP="$(cat .env | grep TAG_IMAGE | cut -d "=" -f2)"
PROJECT_NAME="$(cat .env | grep PROJECT_NAME | cut -d "=" -f2)"

if [[ "$(docker images -q php:$PHP 2>/dev/null)" == "" ]]; then
  cd php/$PHP
  docker build -t php:$PHP .
  cd ../
  cd ../
fi

docker-compose up -d
docker exec -it "$PROJECT_NAME" bash
