resource "aws_instance" "Web_server" {
  ami           = "ami-0532be01f26a3de55" # 's' remove kar diya hai
  instance_type = "t3.micro"
  key_name      = "MyLinuxKeyPair"

  # --- 🛡️ Reliability Pillar: Accidental Deletion Protection ---
  # AWS Whitepaper point: Human error se bachata hai.
  # SAA-C03: Jab ye true ho, to Console/CLI/Terraform se termination block ho jati hai.
  # disable_api_termination = true 
  # agr chahe k user date change hone par instace tefrminate kar k ne create kre ga
  user_data_replace_on_change = true
  vpc_security_group_ids = [aws_security_group.webTFsg.id]
  user_data              = file("install_httpd.sh")

  tags = {
    name = "Terraform-modular-server"
  }
}