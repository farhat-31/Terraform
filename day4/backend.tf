terraform {
  backend "s3" {
    bucket = "fahatkhan-s3-bucket"
    key    = "day4/terraform.tfstate"
    region = "us-east-1"
  }
}