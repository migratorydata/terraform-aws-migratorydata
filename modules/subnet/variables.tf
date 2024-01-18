variable "migratorydata_prefix" {
  description = "Prefix prepended to all resources created."
  default     = "migratorydata-"
  type        = string
}

variable "cidr_block" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "gateway_id" {
  type = string
}

variable "availability_zone" {
  type = string
}