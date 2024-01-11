output "Public-IP" {
  value = aws_instance.public_ec2_instance.public_ip
}

output "Private-IP" {
  value = aws_instance.public_ec2_instance.private_ip
}



output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_backend.bucket
}

output "s3_bucket_region" {
  value = aws_s3_bucket.terraform_backend.region
}
