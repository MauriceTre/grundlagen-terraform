variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.nano"
}

variable "key_name" {
  description = "SSH key name"
}