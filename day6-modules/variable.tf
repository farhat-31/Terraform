variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of instance to create."
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The AMI ID to use for the instance."
  type        = string
  default     = "ami-0c02fb55956c7d316"
}
