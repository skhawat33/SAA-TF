resource "aws_instance" "Web_server" {
  ami = "ami-051f8b213835a83bc"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webTFsg.id]
  user_data = file("install_httpd.sh")
  tags = {
    name = "Terraform-modular-server"
  }
}