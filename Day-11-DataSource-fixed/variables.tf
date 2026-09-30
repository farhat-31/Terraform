variable "region" {
  description = "Region where the subnet exists"
  type        = string
  default     = "us-east-1" # change this to the region that has your subnet
}

variable "subnet_name" {
  description = "Value of the Name tag on the existing subnet"
  type        = string
  default     = "dev" # must match the tag exactly (case-sensitive)
}
