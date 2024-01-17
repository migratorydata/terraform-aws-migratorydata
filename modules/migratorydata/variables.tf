##########################################################
#
# Default values for creating a MigratoryData cluster on AWS.
#
##########################################################

variable "associate_public_ip_address" {
  description = "Associate public IP address to instances created."
  default     = true
  type        = string
}

variable "cluster_name" {
  description = "The name for the cluster (universe) being created."
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

variable "migratorydata_prefix" {
  description = "Prefix prepended to all resources created."
  default     = "migratorydata-"
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

variable "ssh_user" {
  description = "The user name to use when connecting to the instances."
  type        = string
  default     = "admin"
}

variable "region_name" {
  description = "Region name for AWS. Example: 'us-west-2'"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to create the security groups in."
  type        = string
}

variable "migratorydata_download_url" {
  description = "The download url for MigratoryData server to install"
  default     = "https://migratorydata.com/releases/migratorydata-6.0.14/migratorydata-6.0.14-build20231031.x86_64.deb"
  type        = string
}

variable "sg_ids" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "cloud_provider" {
  type    = string
  default = "AWS"
}
