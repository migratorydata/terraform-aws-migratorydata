variable "migratorydata_prefix" {
  description = "Prefix prepended to all resources created."
  default     = "migratorydata-"
  type        = string
}

variable "cidr_block" {
  type = string
}