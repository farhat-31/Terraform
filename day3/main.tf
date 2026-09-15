resource "aws_vpc" "name" {
cidr_block = var.vpc_cidr

tags = {
Name = "farhat-vpc"
}
}

resource "aws_internet_gateway" "farhat-igw" {
vpc_id = aws_vpc.name.id

tags = {
Name = "farhat-igw"
}
}

resource "aws_subnet" "farhat-subnet" {
vpc_id            = aws_vpc.name.id
cidr_block        = var.subnet_cidr
availability_zone = var.availability_zone

tags = {
Name = "farhat-subnet"
}
}

resource "aws_subnet" "farhat-private-subnet" {
vpc_id            = aws_vpc.name.id
cidr_block        = var.private_subnet_cidr
availability_zone = var.availability_zone

tags = {
Name = "farhat-private-subnet"
}
}

resource "aws_eip" "farhat-eip" {
domain = "vpc"

tags = {
Name = "farhat-eip"
}
}

resource "aws_nat_gateway" "farhat-nat-gateway" {
allocation_id = aws_eip.farhat-eip.id
subnet_id     = aws_subnet.farhat-subnet.id

tags = {
Name = "farhat-nat-gateway"
}

depends_on = [
aws_internet_gateway.farhat-igw
]
}

resource "aws_route_table" "farhat-route-table" {
vpc_id = aws_vpc.name.id

route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.farhat-igw.id
}

tags = {
Name = "farhat-route-table"
}
}

resource "aws_route_table_association" "farhat-subnet-route-table-association" {
subnet_id      = aws_subnet.farhat-subnet.id
route_table_id = aws_route_table.farhat-route-table.id
}

resource "aws_security_group" "farhat-security-group" {
name        = "farhat-security-group"
description = "Security group for farhat"
vpc_id      = aws_vpc.name.id

ingress {
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = [var.ssh_cidr]
}

ingress {
from_port   = 80
to_port     = 80
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

resource "aws_instance" "farhat-instance" {
ami           = var.ami_id
instance_type = var.instance_type
subnet_id     = aws_subnet.farhat-subnet.id

vpc_security_group_ids = [
aws_security_group.farhat-security-group.id
]

tags = {
Name = "farhat-instance"
}
}
