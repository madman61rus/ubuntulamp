#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y apache2

if ! [ -d /vagrant/www/html ]; then
  if ! [ -L /var/www/html ]; then
    rm -rf /var/www/html
    mkdir -p /vagrant/www/html
    ln -fs /vagrant/www/html /var/www/html
  fi
fi

#if ! [ -d /vagrant/www/html/laravell ]; then
#  mkdir -p /vagrant/www/html/laravell
#fi

debconf-set-selections <<< "mysql-server mysql-server/root_password password coolroot"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password coolroot"
apt-get install mysql-server -y > /dev/null

echo "Installing PHP"
  apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null

echo "Installing PHP extensions"
  apt-get install libapache2-mod-php5 php5-json php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null

echo "Installing PHP extensions"
    apt-get install curl unzip openssl mcrypt -y > /dev/null

echo "Installing Git"
  apt-get install git -y > /dev/null

echo "Enable mod rewrite extension"
  a2enmod rewrite

echo "Enable apache mod"
  a2enmod php5

echo "Restarting apache"
  service apache2 restart
