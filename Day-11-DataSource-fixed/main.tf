# Look up an existing subnet by its Name tag
data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

# Look up the latest Amazon Linux 2 AMI
data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Use both data sources in a resource
resource "aws_instance" "name" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.name.id

  tags = {
    Name = "day-11-datasource"
  }
}

output "subnet_id" {
  value = data.aws_subnet.name.id
}

output "ami_id" {
  value = data.aws_ami.amzlinux.id
}
