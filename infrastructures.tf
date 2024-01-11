# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.subnet_cidr_blocks)
  cidr_block              = var.subnet_cidr_blocks[count.index]
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
}

# Route table for public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate route table with subnets
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Key Pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-terra-key"
  public_key = file("my-terra-key.pub")
}

# Create Security Group
resource "aws_security_group" "my_SG_terraform" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# My EC2 Instance in Public Subnet
resource "aws_instance" "public_ec2_instance" {
  ami                    = var.ami_ids[var.aws_region]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_SG_terraform.id]
  subnet_id              = aws_subnet.public_subnet[0].id  # Assuming you want to use the first subnet

  tags = {
    Env = "Dev"
  }

  provisioner "file" {
    source      = "app.sh"
    destination = "/tmp/app.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/app.sh",
      "sudo /tmp/app.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file("my-terra-key")
    host        = self.public_ip
  }
}