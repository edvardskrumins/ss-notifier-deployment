#!/bin/bash

echo "Current user: $(whoami)"
echo "Current user ID: $(id -u)"
echo "Current group ID: $(id -g)"
echo "Current directory: $(pwd)"

# Ensure storage directories exist
# Ensure storage directories are writable
# mkdir -p /var/www/html/storage/logs
# mkdir -p /var/www/html/storage/framework/cache
# mkdir -p /var/www/html/storage/framework/sessions
# mkdir -p /var/www/html/storage/framework/views
# chown -R www-data:www-data /var/www/html/storage
# chmod -R 775 /var/www/html/storage

echo "Directory contents:"
ls -la

echo "Installing dependencies"

composer install
php artisan migrate
php artisan cache:clear

echo "Starting php-fpm"
php-fpm -R

