output "server-debug" {
  sensitive = false
  value     = "http://${module.migratorydata_cluster.public_ips[0]}:8800"
}

output "instance_ids" {
  sensitive = false
  value     = module.migratorydata_cluster.instance_ids
}

output "migratorydata_cluster_address" {
  description = "dns name of the nlb"
  value       = "http://${module.elb.elb_dns_name}"
}