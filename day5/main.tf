resource "aws_vpc" "fahat" {
  cidr_block = var.vpc_cidr
    tags = {
        Name = "fahat"
    }
}
    resource "aws_subnet" "fahat-subnet" {
        vpc_id            = aws_vpc.fahat.id
        cidr_block        = var.subnet_cidr
    }
    resource "aws_s3_bucket" "fahat-s3" {
            tags = {
            Name = var.s3_bucket_name
        }
    }
    resource "aws_instance" "fahat-ec2" {
        ami           = var.ami_id
        instance_type = var.instance_type
        subnet_id     = aws_subnet.fahat-subnet.id
        tags = {
            Name = "fahat-ec2"
        }
    }