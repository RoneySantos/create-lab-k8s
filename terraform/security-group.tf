resource "aws_security_group" "acesso-ssh-terraform" {
  name        = "acesso ssh via terrafor"
  description = "Criado via terraform"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdir_acesso_remoto
  }

  tags = {
    Name = "ssh"
  }
}
