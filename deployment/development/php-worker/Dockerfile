FROM php:8.4-cli

# Arguments
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
    supervisor \
    curl \
    unzip \
    postgresql-client \
    libicu-dev \
    libzip-dev \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure intl && \
    docker-php-ext-install intl zip pdo pdo_pgsql pgsql

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy PHP configuration
COPY php.ini /usr/local/etc/php/php.ini

# Set working directory
WORKDIR /var/www/html

# Create and configure user
RUN usermod -u $uid $user && \
    groupmod -g $gid $user && \
    mkdir -p /home/$user && \
    chown -R $user:$user /home/$user

# Create supervisor log directory
RUN mkdir -p /var/log/supervisor && \
    chown -R www-data:www-data /var/log/supervisor

# Copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy cron configuration
COPY ./cron /etc/cron.d/cron
RUN chmod 0644 /etc/cron.d/cron && \
    crontab /etc/cron.d/cron && \
    touch /var/log/cron.log

# Copy application files
COPY --chown=$user:$user . .

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to root for supervisor
USER root

# Start supervisor
CMD ["/entrypoint.sh"]