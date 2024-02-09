##########################################################
#
# Default values for creating a MigratoryData cluster on AWS.
#
##########################################################

variable "cluster_name" {
  description = "The name for the cluster (universe) being created."
  default = "migratorydata-cluster"
  type        = string
}

variable "migratorydata_download_url" {
  description = "The download url for MigratoryData server to install"
  default     = "https://migratorydata.com/releases/migratorydata-6.0.15/migratorydata-6.0.15-build20240209.x86_64.deb"
  type        = string
}

variable "migratorydata_prefix" {
  description = "Prefix"
  default     = "migratorydata-"
  type        = string
}

variable "instance_type" {
  description = "The type of instances to create."
  default     = "t2.large"
  type        = string
}

variable "max_num_instances" {
  description = "Maximum number of instances in the MigratoryData cluster."
  default     = 5
  type        = number
}

variable "num_instances" {
  description = "Number of instances in the MigratoryData cluster."
  default     = 3
  type        = number
}

variable "associate_public_ip_address" {
  description = "Flag to control use of public or private ips for ssh."
  default     = "true"
  type        = string
}

variable "ssh_keyname" {
  description = "The SSH keypair name to use for the instances."
  type        = string
}

variable "ssh_private_key" {
  description = "The private key to use when connecting to the instances."
  type        = string
}

variable "cidr_block" {
  description = "cidr block"
  default     = "10.0.0.0/16"
  type        = string
}

variable "region_name" {
  description = "Number of instances in the MigratoryData cluster."
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type = string
}

variable "migratorydata_ingress_with_cidr_blocks" {
  description = "ingress of MigratoryData."
  type        = list(any)
  default = [
    {
      description = "ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "clients port connection"
      from_port   = 8800
      to_port     = 8800
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "cluster communication port"
      from_port   = 8801
      to_port     = 8801
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "cluster communication port"
      from_port   = 8802
      to_port     = 8802
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "cluster communication port"
      from_port   = 8803
      to_port     = 8803
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "cluster communication port"
      from_port   = 8804
      to_port     = 8804
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "statistics"
      from_port   = 9900
      to_port     = 9900
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

variable "migratorydata_egress_with_cidr_blocks" {
  description = "egress with cidr blocks"
  type        = list(any)
  default = [
    {
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "forwarding_config" {
  description = "forwarding config of nlb"
  type        = map(any)
  default = {
    "80" = {
      dest_port   = 8800,
      protocol    = "TCP"
      description = "ws"
    }
  }
}
