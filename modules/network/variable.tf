variable "vpc_cidr_block" {
  type = "string"
  default = "172.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  type = "string"
  default = "172.0.1.0/24"
}

variable "public_subnet_cidr_block" {
  type = "string"
  default = "172.0.2.0/24"
}

