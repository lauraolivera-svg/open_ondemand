#!/bin/bash

systemctl stop httpd
yum remove ondemand* -y
sudo yum remove python3-websockify -y
sudo rm -rf /var/www/ood
sudo rm -rf /etc/ood/
sudo rm -rf /opt/ood/

sudo dnf remove epel-release rclone ruby-devel rubygem-rake rubygems-devel sqlite-devel automake check-devel curl-devel gcc httpd-devel jansson-devel make nano nodejs pcre-devel rpm-build rpmdevtools ruby vim wget yum-utils libffi-devel libyaml-devel lua-posix selinux-policy-devel scl-utils scl-utils-build mod_ldap mod_ssl gd.x86_64
dnf remove mod_auth*
dnf remove cjose*
dnf remove turbovnc*
dnf remove ondemand-nginx*
dnf remove ondemand-scldevel*
dnf remove ondemand-gems*
