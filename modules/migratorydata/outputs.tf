
output "server-debug" {
  sensitive = false
  value     = "http://${aws_instance.migratorydata_nodes[0].public_ip}:8800"
}

output "public_ips" {
  sensitive = false
  value     = aws_instance.migratorydata_nodes.*.public_ip
}

output "private_ips" {
  sensitive = false
  value     = aws_instance.migratorydata_nodes.*.private_ip
}

output "instance_ids" {
  sensitive = false
  value     = aws_instance.migratorydata_nodes.*.id
}
