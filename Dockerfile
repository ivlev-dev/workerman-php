FROM php:8.3.13-alpine

RUN docker-php-ext-enable opcache
RUN apk --no-cache add linux-headers && docker-php-ext-install sockets posix pcntl 
RUN apk --no-cache add $PHPIZE_DEPS openssl-dev libevent-dev && pecl install event && docker-php-ext-enable --ini-name zz-event.ini event

COPY --from=composer:2.8.2 /usr/bin/composer /usr/local/bin/composer
