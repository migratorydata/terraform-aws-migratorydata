variable "namespace" {
  type = string
}

variable "region" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_count" {
  type = number
}

variable "instance_ids" {
  type = list(string)
}

variable "forwarding_config" {
  type = map(any)
}

variable "vpc_id" {
  type = string
}
