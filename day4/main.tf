
# VPC
resource "aws_vpc" "fahat" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "fahat"
  }
}

# Subnet
resource "aws_subnet" "fahat-subnet" {
  vpc_id            = aws_vpc.fahat.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "fahat-subnet"
  }
}

# EC2
resource "aws_instance" "fahat-ec2" {
  ami           = "ami-0e34b50e714a297f1"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.fahat-subnet.id

  tags = {
    Name = "fahat-ec2"
  }
}
resource "aws_s3_bucket" "fahat-s3" {
    bucket = var.bucket_name
  tags = {
    Name = "fahatkhan-s3"
  }
}