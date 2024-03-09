#!/bin/bash

apt-get update
apt-get -y install wget gnupg ca-certificates luarocks libssl-dev git
wget -O - https://openresty.org/package/pubkey.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/openresty.gpg

luarocks-5.1 install lapis
luarocks-5.1 install lua-resty-rsa

codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`

echo "deb http://openresty.org/package/debian $codename openresty" \
    | sudo tee /etc/apt/sources.list.d/openresty.list

apt-get update

apt-get -y install --no-install-recommends openresty

if [ ! -d /opt/app ]; then
    git clone https://github.com/hector-vido/lua-app.git /opt/app
fi
cp /vagrant/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

systemctl restart openresty
