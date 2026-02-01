output "y_Server_Ip" {
  description = "The public ip of the web server"
  value = aws_instance.Web_server.public_ip
}

output "My_website_url" {
  description = "The url of the website"
  value = "http://${aws_instance.Web_server.public_ip}"
}