#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable http
echo "<h1>Instance $(hostname -f)</h1>" > /var/www/html/index.html
