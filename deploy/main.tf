module "migratorydata_vpc" {
  source = "../modules/vpc"

  namespace     = var.namespace
  address_space = var.address_space
}

module "migratorydata_subnet" {
  source = "../modules/subnet"

  namespace         = var.namespace
  vpc_id            = module.migratorydata_vpc.vpc_id
  address_space     = cidrsubnet(var.address_space, 4, 0)
  availability_zone = var.availability_zone
  gateway_id        = module.migratorydata_vpc.gw_id

}

module "elb_subnet" {
  source = "../modules/subnet"

  namespace         = var.namespace
  vpc_id            = module.migratorydata_vpc.vpc_id
  address_space     = cidrsubnet(var.address_space, 4, 1)
  availability_zone = var.availability_zone
  gateway_id        = module.migratorydata_vpc.gw_id
}

module "migratorydata_security_group" {
  source = "../modules/security_group"

  namespace     = var.namespace
  vpc_id        = module.migratorydata_vpc.vpc_id
  ingress_rules = var.migratorydata_ingress_security_rules
  egress_rules  = var.migratorydata_egress_security_rules
}

module "migratorydata_cluster" {
  source = "../modules/migratorydata"

  namespace = var.namespace
  vpc_id    = module.migratorydata_vpc.vpc_id
  subnet_id = module.migratorydata_subnet.subnet_ids
  sg_ids    = [module.migratorydata_security_group.sg_id]

  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  region                      = var.region
  address_space               = var.address_space
  num_instances               = var.num_instances
  max_num_instances           = var.max_num_instances

  # debian ssh login user is `admin`
  ssh_user        = "admin"
  ssh_keyname     = var.ssh_keyname
  ssh_private_key = var.ssh_private_key

  migratorydata_download_url = var.migratorydata_download_url
}

module "elb" {
  source = "../modules/nlb"

  namespace         = var.namespace
  region            = var.region
  instance_count    = var.num_instances
  subnet_ids        = [module.elb_subnet.subnet_ids]
  forwarding_config = var.nlb_forwarding_config
  vpc_id            = module.migratorydata_vpc.vpc_id
  instance_ids      = module.migratorydata_cluster.instance_ids
}
