resource "aws_instance" "Web_server" {
  ami = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  key_name = "MyLinuxKeyPair"
  vpc_security_group_ids = [aws_security_group.webTFsg.id]
  user_data = file("install_httpd.sh")
  tags = {
    name = "Terraform-modular-server"
  }
}