provider "aws" {
  region = "eu-central-1"
}

# Sicherheitsgruppe definieren
resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Security group for SSH access"  # ASCII-only description
  vpc_id      = "vpc-04028e8a2a102aa3a"  # Ersetze durch deine VPC-ID

  # Regel für eingehenden SSH-Zugriff
  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Alle ausgehenden Verbindungen erlauben
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# EC2-Instanz definieren
resource "aws_instance" "ec2_sklave" {
  instance_type = "t2.nano"
  ami           = "ami-071878317c449ae48"
  
  # Sicherheitsgruppe zuweisen
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  # SSH-Schlüsselpaar hinzufügen
  key_name = "terraform"  

  tags = {
    Name = "ec2_sklave"
  }
}
