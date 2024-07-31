terraform {
  backend "s3" {
    bucket = "terraform-vpc-test"
    key    = "ec2-vpc/vpc.tfstate"
    region = "eu-central-1"
  }
}