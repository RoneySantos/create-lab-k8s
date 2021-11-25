# output "dev2" {
#   value = "${aws_instance.dev2.public_ip}"
# }

output "my_ip_addr" {
  value = local.ifconfig_co_json
}