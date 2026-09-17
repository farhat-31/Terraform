variable "vpc_cidr" {
description = "CIDR block for VPC"
default     = ""
type        = string
}

variable "subnet_cidr" {
description = "CIDR block for public subnet"
default     = ""
type        = string
}
variable "s3_bucket_name" {
description = "Name for the S3 bucket"
default     = ""
type        = string
}
variable "ami_id" {
description = "AMI ID for EC2"
default     = ""
type        = string
}
variable "instance_type" {
description = "EC2 instance type"
default     = ""
type        = string
}