
variable "associate_public_ip_address" {
  description = "Associate public IP address to instances created."
  type        = string
}

variable "instance_type" {
  description = "The type of instances to create."
  type        = string
}

variable "max_num_instances" {
  description = "Maximum number of instances in the MigratoryData cluster."
  type        = number
}

variable "num_instances" {
  description = "Number of instances in the MigratoryData cluster."
  type        = number
}

variable "namespace" {
  type = string
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

variable "region" {
  description = "Region name for AWS. Example: 'us-west-2'"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to create the security groups in."
  type        = string
}

variable "migratorydata_download_url" {
  description = "The download url for MigratoryData server to install"
  type        = string
}

variable "sg_ids" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "address_space" {
  type = string
}

variable "cloud_provider" {
  type    = string
  default = "AWS"
}
