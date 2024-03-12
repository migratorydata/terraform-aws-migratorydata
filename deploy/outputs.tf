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

output "monitor-public-ip-grafana-access" {
  sensitive = false
  value     = var.enable_monitoring ? "http://${module.migratorydata_cluster.monitor_public_ip}:3000" : ""
}

resource "local_file" "hosts_ini" {
  content = templatefile("${path.module}/templates/hosts_ini.tpl",
    {
      migratorydata_public_ips = module.migratorydata_cluster.public_ips
      migratorydata_private_ips = module.migratorydata_cluster.private_ips
      ssh_user                 = "${var.ssh_user}"
      ssh_private_key          = "${var.ssh_private_key}"

      enable_monitoring  = "${var.enable_monitoring}"
      monitor_public_ip  = var.enable_monitoring ? "${module.migratorydata_cluster.monitor_public_ip}" : ""
      monitor_private_ip = var.enable_monitoring ? "${module.migratorydata_cluster.monitor_private_ip}" : ""
    }
  )
  filename = "${path.module}/artifacts/hosts.ini"
}

resource "local_file" "cluster_members" {
  content = templatefile("${path.module}/templates/cluster_members.tpl",
    {
      cluster_members = module.migratorydata_cluster.migratorydata_cluster_members
    }
  )
  filename = "${path.module}/artifacts/clustermembers"
}