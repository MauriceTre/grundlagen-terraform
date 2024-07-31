provider "aws" {
  region = "eu-central-1"
}

# Importiere die VPC-ID und die öffentlichen Subnet-IDs aus dem VPC-Deployment
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-vpc-test"
    key    = "ec2-vpc/vpc.tfstate"
    region = "eu-central-1"
  }
}