#!/bin/zsh

docker build -t php-tools:$1 .
docker tag php-tools:$1 grzegab/php-tools:$1
docker push grzegab/php-tools:$1