resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "farhat-vpc"
  }
}



resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "farhat-subnet-1"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "farhat-subnet-2"
  }
}

resource "aws_instance" "main" {
  ami                    = "ami-0354c98ae10b02961"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "farhat-instance"
  }
}

# Security Group
resource "aws_security_group" "main" {
  name        = "farhat-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "farhat-sg"
  }
}

# Inbound Rule - SSH
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.main.id
  
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "allow-ssh"
  }
}

# Inbound Rule - HTTP
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.main.id
  
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "allow-http"
  }
}

# Inbound Rule - HTTPS
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.main.id
  
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "allow-https"
  }
}

# Outbound Rule - All Traffic
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.main.id
  
  from_port   = 0
  to_port     = 65535
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "allow-all-outbound"
  }
}

resource "aws_eip" "main" {
  domain = "vpc"

  tags = {
    Name = "farhat-eip"
  }

  depends_on = [aws_vpc.main]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "farhat-nat-gateway"
  }

  depends_on = [aws_eip.main]
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "farhat-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name = "farhat-public-rt"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.main.id
  }

  tags = {
    Name = "farhat-private-rt"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.secondary.id
  route_table_id = aws_route_table.private.id
}