terraform {
  backend "s3" {
    bucket = "farhatkhan-s3-bucket"
    key    = "day5/terraform.tfstate"
    region = "us-east-1"
    #lock_table = "farhatkhan-lock-table"
    use_lockfile = true
  }
}