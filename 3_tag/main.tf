resource "aws_instance" "ec2_hexe" {
  ami             = "ami-0e872aee57663ae2d"
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.ssh_access.id]
  key_name        = var.key_name

  tags = {
    Name = "MeineHexe"
  }



}