resource "aws_security_group" "webTFsg" {
  name = "web-server-sg"
  description = "aws security group created by TF"
ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "116.90.105.4/32", "116.90.105.5/32" ]
}
ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}
}