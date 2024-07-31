# Output der Instance IP-Adresse
output "instance_ip" {
  value = aws_instance.web.public_ip
}