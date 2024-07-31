# Erstelle eine EC2-Instance
resource "aws_instance" "web" {
  ami                    = "ami-01e444924a2233b07" # Ubuntu Server 20.04 LTS für eu-central-1
  instance_type          = "t2.micro"
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_id_1a # Nutzt ein öffentliches Subnetz
  vpc_security_group_ids = [aws_security_group.http.id]
  key_name               = "tictactoe"
  user_data              = file("user_data.sh")
  tags = {
    Name = "TicTacToeInstance"
  }
}

