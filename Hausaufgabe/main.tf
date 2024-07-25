provider "aws" {
  region = "eu-central-1"
}

# Sicherheitsgruppe definieren
resource "aws_security_group" "ingress_access" {
  name        = "allow_ssh"
  description = "Security group for ingress access" # ASCII-only description
  vpc_id      = "vpc-04028e8a2a102aa3a"             # Ersetze durch deine VPC-ID

  # Regel für eingehenden SSH-Zugriff
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Alle ausgehenden Verbindungen erlauben
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2-Instanz definieren
resource "aws_instance" "baklava" {
  instance_type = "t2.micro"
  ami           = "ami-071878317c449ae48"

  # Sicherheitsgruppe zuweisen
  vpc_security_group_ids = [aws_security_group.ingress_access.id]

  # SSH-Schlüsselpaar hinzufügen
  key_name = "terraform"

  tags = {
    Name = "baklava"
  }
}
