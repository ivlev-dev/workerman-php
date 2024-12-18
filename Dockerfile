FROM php:8.4.1

ARG DEBIAN_FRONTEND=noninteractive

RUN docker-php-ext-enable opcache

RUN docker-php-ext-install sockets posix pcntl

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends \
        $PHPIZE_DEPS \
        ^libevent[0-9\.\-]*$ \
        ^libevent-openssl[0-9\.\-]*$ \
        ^libevent-extra[0-9\.\-]*$ \
        ^libevent-pthreads[0-9\.\-]*$ \
        libssl-dev libevent-dev && \
    pecl install event && \
    docker-php-ext-enable --ini-name zz-event.ini event && \
    apt-get -y remove --purge $PHPIZE_DEPS libssl-dev libevent-dev && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=composer:2.8.3 /usr/bin/composer /usr/local/bin/composer
