#!/usr/bin/env bash

# WARNING: only for ubuntu 14.04

sudo apt-get update;
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev;


sudo apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev;
curl -L https://get.rvm.io | bash -s stable;
source ~/.rvm/scripts/rvm;
rvm install 2.2.1;
rvm use 2.2.1 --default;
ruby -v;


sudo add-apt-repository ppa:chris-lea/node.js;
sudo apt-get update;
sudo apt-get -y install nodejs;


sudo apt-get -y install libmagickwand-dev;


###passenger

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7;

sudo apt-get -y install apt-transport-https ca-certificates;



sudo bash -c 'echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list';

sudo apt-get update;

sudo apt-get -y install nginx-extras passenger;



sudo sed -i "s/# passenger_root/passenger_root/" -i "s/# passenger_ruby.*/passenger_ruby \/home\/deployme\/.rvm\/wrappers\/default\/ruby;/" /etc/nginx/nginx.conf > /etc/nginx/nginx.conf2

sudo mv /etc/nginx/nginx.conf  /etc/nginx/nginx.conf_back
sudo mv /etc/nginx/nginx.conf2 /etc/nginx/nginx.conf


sudo mkdir -p /var/www/although.com
sudo chown deployme:deployme /var/www/although.com

cd /var/www/although.com



git clone https://github.com/although2013/MyBlog.git master

cd master

./script/setup_server.sh





rm /etc/nginx/sites-enabled/default

touch /etc/nginx/sites-enabled/although.com.conf


sudo sh -c "echo '''server {
    listen 80 default;
    server_name although2013.com;
    root /var/www/although.com/master/public;
    passenger_enabled on;
}''' > /etc/nginx/sites-enabled/although.com.conf;"


sudo service nginx restart



