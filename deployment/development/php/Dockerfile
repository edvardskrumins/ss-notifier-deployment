FROM php:8.4-fpm

# Arguments - use host user ID to match mounted volume
ARG uid=1000
ARG gid=1000
ARG user=www-data

# Install system dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    nano \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libpq-dev \
    curl \
    unzip \
    postgresql-client \
    libicu-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure intl && \
    docker-php-ext-install intl zip pdo pdo_pgsql pgsql

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy PHP configuration
COPY deployment/development/php/php.ini /usr/local/etc/php/php.ini

# Set working directory
WORKDIR /var/www/html

# Create and configure user to match host user ID and group
RUN usermod -u $uid $user && \
    groupmod -g $gid $user && \
    mkdir -p /home/$user && \
    chown -R $user:$user /home/$user

COPY --chown=$user:$user ss-notifier-api/ .

COPY deployment/development/php/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Keep running as root for system services
USER root

CMD ["/entrypoint.sh"]