provider "aws" {
  
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/24"
  
}

resource "aws_s3_bucket" "name" {
    bucket = "test-devtest-farhat"
  
}

#terraform plan -target=aws_vpc.name to target resources instead of creation all resources 