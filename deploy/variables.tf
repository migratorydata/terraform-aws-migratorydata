
variable "migratorydata_download_url" {
  description = "The download url for MigratoryData server to install"
  type        = string
}

variable "namespace" {
  description = "Prefix all resources with this namespace."
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
  description = "Flag to control if instances have a public IP address."
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

variable "address_space" {
  description = "Address block for the VPC."
  default     = "10.0.0.0/16"
  type        = string
}

variable "region" {
  description = "Region name for AWS. Example: 'us-west-2'"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type = string
}

variable "migratorydata_ingress_security_rules" {
  description = "Ingress security rules of MigratoryData"
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

variable "migratorydata_egress_security_rules" {
  description = "Egress security rules of MigratoryData."
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

variable "nlb_forwarding_config" {
  description = "Forwarding config of nlb"
  type        = map(any)
  default = {
    "80" = {
      dest_port   = 8800,
      protocol    = "TCP"
      description = "ws"
    }
  }
}
