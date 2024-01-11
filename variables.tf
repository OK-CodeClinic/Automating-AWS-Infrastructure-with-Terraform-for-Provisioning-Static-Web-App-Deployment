variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the two subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ami_ids" {
  description = "Map of AMI IDs for different regions"
  type        = map(string)
  default = {
    "us-east-1" = "ami-0005e0cfe09cc9050"
    "us-east-2" = "ami-0cd3c7f72edd5b06d"
    "us-west-1" = "ami-0a5ed7a812aeb495a"
    "us-west-2" = "ami-0944e91aed79c721c"
  }
}

variable "USER" {
  description = "The User to login to the ssh client"
  type        = string
  default     = "ec2-user"
}


