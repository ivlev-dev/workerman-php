FROM php:8.4.1-alpine

RUN docker-php-ext-enable opcache

RUN apk --no-cache add linux-headers && \
    docker-php-ext-install sockets posix pcntl && \
    apk del linux-headers

RUN apk --no-cache add $PHPIZE_DEPS openssl-dev libevent-dev && \
    pecl install event && \
    docker-php-ext-enable --ini-name zz-event.ini event && \
    apk del $PHPIZE_DEPS openssl-dev libevent-dev

COPY --from=composer:2.8.3 /usr/bin/composer /usr/local/bin/composer
