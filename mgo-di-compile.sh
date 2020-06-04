#!/bin/bash

docker-compose exec -u www-data cli /usr/local/bin/magento-di-compile
