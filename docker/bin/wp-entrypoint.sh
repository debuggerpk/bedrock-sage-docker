#!/bin/bash
echo "upgrade composer dependencies"
composer update -vvv
# compose update
exec "$@"
