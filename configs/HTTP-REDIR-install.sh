#!/bin/bash

apt-get update
apt-get install apache2
a2enmod rewrite proxy proxy_http
