provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "lab-k8s-master"{
    ami             = var.amis_aws["ubuntu"]
    instance_type   = "t2.micro"
    key_name        = var.key_name
    tags = {
        Name = "lab-k8s-master"
    }
    vpc_security_group_ids = ["${aws_security_group.cria-portas-master-k8s.id}"]
}

# resource "aws_instance" "lab-k8s-worker"{
#     ami             = var.amis_aws["ubuntu"]
#     count = 2
#     instance_type   = "t2.micro"
#     key_name        = var.key_name
#     tags = {
#         Name = "lab-k8s-worker-${count.index}"
#     }
#     vpc_security_group_ids = ["${aws_security_group.cria-portas-workers-k8s.id}"]
#     depends_on = [aws_instance.lab-k8s-master]
# }
