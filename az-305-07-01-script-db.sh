#!/bin/bash
apt update
apt install -y mysql-server
sudo ufw --force enable
sudo ufw allow 22
sudo ufw allow 3306
sudo ufw reload
sudo systemctl restart mysql
sudo mysql -e "
select user,authentication_string,plugin,host from mysql.user;
alter user 'root'@'localhost' identified with mysql_native_password by 'password';
flush privileges;
select user,authentication_string,plugin,host from mysql.user;
create user 'sqladmin'@'%' identified by 'password';
grant all privileges on *.* to 'sqladmin'@'%' with grant option;
select host from mysql.user where user = 'sqladmin';
create database prod_schema;
use prod_schema;
create table products (id int NOT NULL AUTO_INCREMENT, name varchar(255), quantity varchar(255), price varchar(255), PRIMARY KEY (id));
exit"
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
