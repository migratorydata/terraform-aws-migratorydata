output "cluster-nodes-public-ips" {
  sensitive = false
  value     = module.migratorydata_cluster.public_ips
}

output "instance_ids" {
  sensitive = false
  value     = module.migratorydata_cluster.instance_ids
}

output "migratorydata-nlb-dns" {
  description = "Cluster DNS access address."
  value       = "http://${module.elb.elb_dns_name}"
}