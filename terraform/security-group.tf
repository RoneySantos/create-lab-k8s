##### Security group ####
#####  K8S   Master  ####
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
    Name = "Create terraform ssh"
  }
}

resource "aws_security_group" "acesso-kubelet-api" {
  name        = "acesso kubelet api via terrafor"
  description = "Criado via terraform"

  ingress {
    description      = "TLS from VPC"
    from_port        = 10250
    to_port          = 10250
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Create terraform Kubelet API"
  }
}

resource "aws_security_group" "acesso-kubernetes-api" {
  name        = "acesso Kubernetes API server via terrafor"
  description = "Criado via terraform"

  ingress {
    description      = "TLS from VPC"
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Create terraform Kubernetes API server"
  }
}

resource "aws_security_group" "acesso-etcd-api" {
  name        = "acesso etcd server client API via terrafor"
  description = "Criado via terraform"

  ingress {
    description      = "TLS from VPC"
    from_port        = 2379
    to_port          = 2380
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Create terraform etcd server client API"
  }
}