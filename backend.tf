terraform {
    backend "s3" {
        bucket = "my-terraform-storage"
        key = "terraform/backend"
        region = "us-west-1"
    }
}