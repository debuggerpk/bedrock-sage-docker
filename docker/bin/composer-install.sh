#!/bin/sh
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
composer global require hirak/prestissimo -vvv
