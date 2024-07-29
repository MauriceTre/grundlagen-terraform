terraform {
  backend "s3" {
    bucket = "terraform-test-iac-vpc"
    key    = "test/terraform.tfstate"
    region = "eu-central-1"

  }
}