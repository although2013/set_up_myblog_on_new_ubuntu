#!/usr/bin/env bash

# WARNING: only for ubuntu 14.04

#..................
#useradd -m deployme
#adduser deploy sudo
#passwd deploy
#..................

sudo apt-get update;
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev;


sudo apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev;
curl -L https://get.rvm.io | bash -s stable;
source ~/.rvm/scripts/rvm;
rvm install 2.2.1;
rvm use 2.2.1 --default;
echo "-------ruby version-----ruby version------"
ruby -v;

echo "-------nodejs-----nodejs------"
sudo add-apt-repository -y ppa:chris-lea/node.js;
sudo apt-get update;
sudo apt-get -y install nodejs;



echo "-------RMagick-----RMagick------"
sudo apt-get -y install libmagickwand-dev;

###
###passenger
###
echo "-------Passenger-----Passenger------"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7;

sudo apt-get -y install apt-transport-https ca-certificates;



sudo bash -c 'echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list';

sudo apt-get update;

sudo apt-get -y install nginx-extras passenger;



sudo sh -c 'sed -e "s/# passenger_root/passenger_root/" -e "s/# passenger_ruby.*/passenger_ruby \/home\/deployme\/.rvm\/wrappers\/default\/ruby;/" /etc/nginx/nginx.conf > /etc/nginx/nginx.conf2'

sudo mv /etc/nginx/nginx.conf  /etc/nginx/nginx.conf_back
sudo mv /etc/nginx/nginx.conf2 /etc/nginx/nginx.conf


sudo mkdir -p /var/www/although.com
sudo chown deployme:deployme /var/www/although.com

cd /var/www/although.com



git clone https://github.com/although2013/MyBlog.git master

cd master

#exit
#su - dployme
#cd /var/www/although.com/master

./script/setup_server.sh




sudo rm /etc/nginx/sites-enabled/default

sudo touch /etc/nginx/sites-enabled/although.com.conf


sudo sh -c "echo '''server {
    listen 80 default;
    server_name although2013.com;
    root /var/www/although.com/master/public;
    passenger_enabled on;
}''' > /etc/nginx/sites-enabled/although.com.conf;"


sudo service nginx restart


sudo apt-get autoremove;

