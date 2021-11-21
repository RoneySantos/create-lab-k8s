resource "aws_security_group" "acesso-ssh-terraform" {
  name        = "acesso ssh via terrafor"
  description = "Criado via terraform"
#   vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdir_acesso_remoto
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

  tags = {
    Name = "ssh"
  }
}
