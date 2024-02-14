
locals {
  count_range               = range(0, var.max_num_instances)
  migratorydata_cluster_ips = join(",", [for index in local.count_range : format("%s:8801", cidrhost(var.address_space, index + 5))])
}

data "aws_ami" "migratorydata_ami" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name = "name"

    values = [
      "debian-12-amd64*",
    ]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "migratorydata_nodes" {
  count                       = var.num_instances
  ami                         = data.aws_ami.migratorydata_ami.id
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  key_name                    = var.ssh_keyname == "" ? null : var.ssh_keyname
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_ids

  private_ip = cidrhost(var.address_space, count.index + 5)

  tags = {
    Name          = "${var.namespace}-vm-n${format("%d", count.index + 1)}"
    MigratoryData = "true"
    Service       = "MigratoryData"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.ssh_private_key)
  }

  provisioner "file" {
    source      = "${path.module}/scripts/install.sh"
    destination = "/home/${var.ssh_user}/install.sh"
  }

  provisioner "file" {
    source      = "${path.root}/configs/migratorydata.conf"
    destination = "/home/${var.ssh_user}/migratorydata.conf"
  }

  provisioner "file" {
    source      = "${path.root}/configs/migratorydata"
    destination = "/home/${var.ssh_user}/migratorydata"
  }

  provisioner "file" {
    source      = "${path.root}/configs/addons/kafka/consumer.properties"
    destination = "/home/${var.ssh_user}/kafka-consumer.properties"
  }

  provisioner "file" {
    source      = "${path.root}/configs/addons/kafka/producer.properties"
    destination = "/home/${var.ssh_user}/kafka-producer.properties"
  }

  provisioner "file" {
    source      = "${path.root}/configs/addons/authorization-jwt/configuration.properties"
    destination = "/home/${var.ssh_user}/authorization-jwt-configuration.properties"
  }

  provisioner "file" {
    source      = "${path.root}/configs/addons/audit-log4j/log4j2.xml"
    destination = "/home/${var.ssh_user}/audit-log4j-log4j2.xml"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/${var.ssh_user}/extensions/",
    ]
  }

  provisioner "file" {
    source      = "${path.root}/extensions/"
    destination = "/home/${var.ssh_user}/extensions/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.ssh_user}/install.sh",
      "sudo sh install.sh '${var.migratorydata_download_url}' '${local.migratorydata_cluster_ips}' '${var.cloud_provider}'",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}


