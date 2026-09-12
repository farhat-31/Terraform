resource "aws_vpc" "name"{
  cidr_block =var.vpc_cidr
tags = {
    Name = "farhat-vpc"
  }
}
resource "aws_subnet" "farhat-subnet"{
  vpc_id=aws_vpc.name.id
  cidr_block=var.subnet_cidr
  availability_zone="us-east-1a"
}