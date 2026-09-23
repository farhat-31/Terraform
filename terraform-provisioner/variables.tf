variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to launch (e.g., Amazon Linux 2023 / Ubuntu)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name to register the SSH key pair under in AWS"
  type        = string
  default     = "provisioner-demo-key"
}

variable "public_key_path" {
  description = "Path to local SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to local SSH private key (used by remote-exec connection)"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "ssh_user" {
  description = "SSH username for the AMI (e.g. ec2-user, ubuntu)"
  type        = string
  default     = "ec2-user"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the instance"
  type        = string
  default     = "0.0.0.0/0" # NOTE: restrict this to your own IP in real use
}
