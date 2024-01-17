output "server-debug" {
  sensitive = false
  value     = "http://${module.migratorydata_cluster.public_ips[0]}:8800"
}

output "instance_ids" {
  sensitive = false
  value     = module.migratorydata_cluster.instance_ids
}

output "security_group" {
  sensitive = false
  value     = module.migratorydata_security_group.sg_id
}
