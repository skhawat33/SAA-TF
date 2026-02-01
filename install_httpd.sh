#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome Skhawat Your st Server Deploy on AWS Cloud Via Terraform</h1>" > /var/www/html/index.html