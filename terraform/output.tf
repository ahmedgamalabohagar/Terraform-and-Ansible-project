output "app_public_ip" {
  description = "Public IP of the app host (SSH and HTTP)"
  value       = aws_instance.web_server.public_ip
}

output "app_private_ip" {
  description = "Private IP of the app host"
  value       = aws_instance.web_server.private_ip
}

output "db_public_ip" {
  description = "Public IP of the database host (SSH only)"
  value       = aws_instance.db_server.public_ip
}

output "db_private_ip" {
  description = "Private IP of the database host"
  value       = aws_instance.db_server.private_ip
}

output "ssh_user" {
  description = "Default SSH user of the Ubuntu AMI"
  value       = "ubuntu"
}

output "app_url" {
  description = "Where to open the application"
  value       = "http://${aws_instance.web_server.public_ip}"
}
