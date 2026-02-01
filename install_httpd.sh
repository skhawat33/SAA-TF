Bash
#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to Cloud Folks Hub via Terraform Modular Code</h1>" > /var/www/html/index.html