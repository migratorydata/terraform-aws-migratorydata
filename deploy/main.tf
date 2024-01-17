module "migratorydata_vpc" {
  source = "../modules/vpc"

  cidr_block = var.cidr_block
}

module "migratorydata_subnet" {
  source = "../modules/subnet"

  vpc_id     = module.migratorydata_vpc.vpc_id
  cidr_block = var.cidr_block
  gateway_id = module.migratorydata_vpc.gw_id
}

module "migratorydata_security_group" {
  source = "../modules/security_group"

  vpc_id                   = module.migratorydata_vpc.vpc_id
  ingress_with_cidr_blocks = var.migratorydata_ingress_with_cidr_blocks
  egress_with_cidr_blocks  = var.migratorydata_egress_with_cidr_blocks
}

module "migratorydata_cluster" {
  source = "../modules/migratorydata"

  vpc_id    = module.migratorydata_vpc.vpc_id
  subnet_id = module.migratorydata_subnet.subnet_ids
  sg_ids    = [module.migratorydata_security_group.sg_id]

  cluster_name                = var.cluster_name
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  region_name                 = var.region_name
  cidr_block                  = var.cidr_block
  num_instances               = var.num_instances
  max_num_instances           = var.max_num_instances

  # debug (debian ssh login user is `admin`)
  ssh_user        = "admin"
  ssh_keyname     = var.ssh_keyname
  ssh_private_key = var.ssh_private_key
}
