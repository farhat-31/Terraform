
variable "vpc_cidr" {
description = "CIDR block for VPC"
type        = string
default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
description = "CIDR block for public subnet"
type        = string
default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
description = "CIDR block for private subnet"
type        = string
default     = "10.0.2.0/24"
}

variable "availability_zone" {
description = "Availability Zone"
type        = string
default     = "us-east-1a"
}

variable "ami_id" {
description = "AMI ID for EC2"
type        = string
default     = "ami-0e34b50e714a297f1"
}

variable "instance_type" {
description = "EC2 instance type"
type        = string
default     = "t2.micro"
}

variable "ssh_cidr" {
description = "CIDR allowed for SSH"
type        = string
default     = "0.0.0.0/0"
}
