terraform {
  backend "s3" {
    bucket = aws_s3_bucket.terraform_backend.bucket
    region = aws_s3_bucket.terraform_backend.region
    key    = "terraform.tfstate"
  }
}