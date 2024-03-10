
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

output "migratorydata_cluster_members" {
  sensitive = false
  value     = local.migratorydata_cluster_ips
}

output "monitor_private_ip" {
  sensitive = false
  value     = var.enable_monitoring ? aws_instance.migratorydata_monitor[0].private_ip : ""
}

output "monitor_public_ip" {
  sensitive = false
  value     = var.enable_monitoring ? aws_instance.migratorydata_monitor[0].public_ip : ""
}