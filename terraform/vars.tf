variable "amis_aws" {
  type = map
  default = {
    "ubuntu"  = "ami-0629230e074c580f2"
    "amazon" = "ami-0d718c3d715cec4a7"
  }
}

variable "cdir_acesso_remoto" {
    type = list(string)
    default = ["177.158.121.90/32","177.158.121.91/32"]
}

variable "key_name" {
  default = "terraform-aws"
}