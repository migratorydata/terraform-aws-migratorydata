variable "namespace" {
  type = string
}

variable "ingress_rules" {
  type = list(any)
}

variable "egress_rules" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}
