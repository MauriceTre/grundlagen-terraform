terraform {
  backend "s3" {
    bucket = "terraform-test-iac"
    key    = "test/terraform.tfstate"
    region = "eu-central-1"

  }
}