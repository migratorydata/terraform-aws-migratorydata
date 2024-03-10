
locals {
  count_range               = range(0, var.max_num_instances)
  migratorydata_cluster_ips = join(",", [for index in local.count_range : format("%s:8801", cidrhost(var.address_space, index + 5))])
  monitor_private_ip             = cidrhost(var.address_space, var.max_num_instances + 10)
}

data "tls_public_key" "private_key_openssh" {
  private_key_openssh = file(var.ssh_private_key)
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.namespace}-keypair"
  public_key = data.tls_public_key.private_key_openssh.public_key_openssh
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
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_ids

  private_ip = cidrhost(var.address_space, count.index + 5)

  tags = {
    Name          = "${var.namespace}-vm-n${format("%d", count.index + 1)}"
    MigratoryData = "true"
    Service       = "MigratoryData"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "migratorydata_monitor" {
  count                        = var.enable_monitoring ? 1 : 0
  ami                         = data.aws_ami.migratorydata_ami.id
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_ids

  private_ip = local.monitor_private_ip

  tags = {
    Name          = "${var.namespace}-vm-monitor"
    MigratoryData = "true"
    Service       = "MigratoryData"
  }
}


