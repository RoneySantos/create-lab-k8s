##### Security group ####
#####  K8S   Master  ####
resource "aws_security_group" "cria-portas-master-k8s" {
  name        = "Portas Master K8S"
  description = "Portas master K8S criado via terraform"

ingress {
  description      = "Acesso ssh"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["${local.my_ip_local_internet}/32"]
}
ingress {
description      = "Acesso kubelet api"
  from_port        = 10250
  to_port          = 10250
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "Acesso kubernetes api"
  from_port        = 6443
  to_port          = 6443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "Acesso etcd api"
  from_port        = 2379
  to_port          = 2380
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "Kube scheduler"
  from_port        = 10251
  to_port          = 10251
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "Kube Controller Manager"
  from_port        = 10252
  to_port          = 10252
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "Proprio SG"
  from_port        = 0
  to_port          = 0
  protocol         = "tcp"
  self = true
}
egress {
  description      = "Liberando saida"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}
tags = {
    Name = "K8S-MASTER-PORT-TERRAFORM"
  }
}

##### Security group ####
#####  K8S  WORKERS  ####
resource "aws_security_group" "cria-portas-workers-k8s" {
  name        = "Portas Workers K8S"
  description = "Portas Workes K8S criado via terraform"

ingress {
  description      = "Acesso ssh"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["${local.my_ip_local_internet}/32"]
}
ingress {
  description      = "NodePort Service All"
  from_port        = 6783
  to_port          = 6784
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "Kubelet API"
  from_port        = 10250
  to_port          = 10250
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
  description      = "NodePort"
  from_port        = 30000
  to_port          = 32767
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
}
egress {
  description      = "Liberando saida"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}
tags = {
    Name = "K8S-WORKER-PORT-TERRAFORM"
  }
}