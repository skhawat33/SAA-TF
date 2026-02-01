Maine poore setup ko 4 alag files mein divide kar diya hai. In sab ko ek hi folder mein rakhein:

1. provider.tf
Is file mein AWS region aur provider ki details hoti hain.

Terraform
provider "aws" {
  region = "us-east-1" # Aap apna region yahan likh sakte hain
}
2. sg.tf
Is file mein sirf Security Group ke rules honge.

Terraform
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["116.90.105.4/32",] # Best practice: Replace with your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
3. install_httpd.sh (User Data Script)
Ye wo script hai jo EC2 launch hote hi Apache install karegi.

Bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to Cloud Folks Hub via Terraform Modular Code</h1>" > /var/www/html/index.html
4. ec2.tf
Ye main file hai jo instance banaye gi aur ooper wali files ko link karegi.

Terraform
resource "aws_instance" "web_server" {
  ami           = "ami-051f8b213835a83bc" # Amazon Linux 2023 (Region check kar lein)
  instance_type = "t3.micro"
  
  # Security Group ko link karna
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # User Data script file ko link karna
  user_data = file("install_httpd.sh")

  tags = {
    Name = "Terraform-Modular-Server"
  }
}
🛡️ Technical Cheat Sheet (AWS Whitepaper & SAA-C03)
Separation of Concerns: Alag files rakhne ka faida ye hai ke agar aapko sirf Security Group change karna ho, to aapko poora EC2 code chhairne ki zaroorat nahi parti.

Implicit Dependency: Terraform itna smart hai ke usay pata hai pehle Security Group banana hai aur phir EC2, kyunke ec2.tf mein SG ki ID use ho rahi hai. [cite: 2026-01-31]

State Management: Jab aap terraform apply karenge, to ye sari .tf files mil kar ek single terraform.tfstate file banayengi jo aapke infra ka record rakhegi.