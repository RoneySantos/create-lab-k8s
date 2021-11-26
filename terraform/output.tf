output "conecta_master-k8s" {
  value = "ssh -i ~/.ssh/terraform-aws ubuntu@${aws_instance.lab-k8s-master.public_dns}"
}

output "ip_publico" {
  value = "Esse e seu ip atual: ${local.my_ip_local_internet}"
}

output "teste"{
  value = aws_security_group.cria-portas-master-k8s.arn
}
