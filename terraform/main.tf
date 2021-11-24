# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "3.66.0"
#     }
#   }
# }

provider "aws" {
#   version = "3.66.0"
  region = "us-east-2"
}

resource "aws_instance" "lab-k8s-master"{
    ami             = var.amis_aws["ubuntu"]
    instance_type   = "t2.micro"
    key_name        = var.key_name
    tags = {
        Name = "lab-k8s-master"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-terraform.id}"]
}

resource "aws_instance" "dev2"{
    ami             = var.amis_aws["ubuntu"]
    count = 2
    instance_type   = "t2.micro"
    key_name        = var.key_name
    tags = {
        Name = "lab-k8s-worker-${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-terraform.id}"]
    depends_on = [aws_instance.lab-k8s-master]
}


# resource "aws_s3_bucket" "dev2" {
#   bucket = "roneylab-dev2"
#   acl    = "private"

#   tags = {
#     Name        = "roneylab-dev2"
#   }
# }