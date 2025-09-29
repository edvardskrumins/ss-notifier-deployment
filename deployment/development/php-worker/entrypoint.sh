#!/bin/bash

composer install
php artisan cache:clear

service cron start

# Run supervisord in non-daemon mode
echo "Launching supervisord..."
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
