# syntax=docker/dockerfile:1

FROM php:8.2-cli as base

RUN echo '[-] Installing Composer ...' \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

COPY tools/ /app

RUN apt-get update \
    && apt-get install -qy git ssh gpg libicu-dev libzip-dev unzip libxslt-dev \
    && docker-php-ext-install intl zip bcmath pdo pdo_mysql xsl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PHP_MEMORY_LIMIT=512M

RUN pecl install pcov && docker-php-ext-enable pcov

RUN echo '[X] INSTALL tools' \
    && composer install --working-dir=php-cs-fixer \
    && composer install --working-dir=phpstan \
    && composer install --working-dir=rector \
    && composer install --working-dir=phpunit

RUN echo '[X] Prepare exe files' \
    && chmod +x check \
    && chmod +x pipeline \
    && chmod +x fix

RUN rm -rf /var/lib/apt/lists/*