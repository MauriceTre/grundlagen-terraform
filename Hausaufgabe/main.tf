provider "aws" {
  region = "eu-central-1"
}

# Security Group erstellen, die SSH über IPv4 (überall) erlaubt
resource "aws_security_group" "allow_ingress" {
  # keine verpflichtende Argumente bei Security-Groups
}

resource "aws_security_group_rule" "ingress_ssh" {
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.allow_ingress.id
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "ingress_HTTP" {
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.allow_ingress.id
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "ingress_HTTPS" {
  from_port         = 443
  to_port           = 443
  security_group_id = aws_security_group.allow_ingress.id
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "egress" {
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.allow_ingress.id
  protocol          = "-1"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_instance" "Baklava" {
  ami           = "ami-071878317c449ae48"
  instance_type = "t2.micro"

  # Instanz einen Name-Tag für AWS-Management-Konsole geben
  tags = {
    Name = "Baklava"
  }

  # Instanz mit Security-Group verknüpfen
  vpc_security_group_ids = [aws_security_group.allow_ingress.id]
}

resource "aws_s3_bucket" "mammamia" {

}

resource "aws_dynamodb_table" "tesla" {
  name = "tesla-table"
  read_capacity   = 5
  write_capacity  = 5
  hash_key        = "id"

  attribute {
    name = "id"
    type = "S"
}
}
# Instanz-IP ausgeben
output "baklava_ip" {
  value = aws_instance.Baklava.public_ip
}
output "name_der_security_gruppe" {
  value = aws_security_group.allow_ingress.name
}
output "Arn" {
  value = aws_security_group.allow_ingress.arn
}
output "aws_dynamodb_table" {
  value = aws_dynamodb_table.tesla.name
}
output "s3" {
  value = aws_s3_bucket.mammamia.id
}