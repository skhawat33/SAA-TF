resource "aws_instance" "Web_server" {
  ami = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  key_name = "MyLinuxKeyPair"
  Aapka point bilkul valid hai. SAA-C03 exam aur AWS Whitepapers (Reliability aur Security Pillars) ke mutabiq, humne **Termination Protection** ke concept ko optimize aur merge kar diya hai.

Yahan sirf **Termination Protection** par focus karte hue technical details di gayi hain jo aapke project aur exam ke liye zaroori hain:

### 🛠️ Optimized `Ec2.tf` (Termination Protection Focus)

Humne aapki file mein `disable_api_termination` attribute add kiya hai jo human error se bachata hai.

```hcl
resource "aws_instance" "Web_server" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  key_name      = "MyLinuxKeyPair"

  # --- 🛡️ Reliability Pillar: Accidental Deletion Protection ---
  # Ye line console ya CLI se ghalti se termination ko rokti hai.
  # SAA-C03: Agar ye 'true' hai, to API call (destroy) fail ho jayegi.
  disable_api_termination = true 
  s
  vpc_security_group_ids = [aws_security_group.webTFsg.id]
  user_data = file("install_httpd.sh")
  tags = {
    name = "Terraform-modular-server"
  }
}