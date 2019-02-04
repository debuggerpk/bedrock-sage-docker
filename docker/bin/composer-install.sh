#!/bin/sh
printf "\nInstalling Composer\n"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
composer config -g repo.packagist composer https://packagist.org
composer config -g github-protocols https ssh
composer global require hirak/prestissimo -vvv
