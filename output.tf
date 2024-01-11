output "Public-IP" {
  value = aws_instance.public_ec2_instance.public_ip
}

output "Private-IP" {
  value = aws_instance.public_ec2_instance.private_ip
}
