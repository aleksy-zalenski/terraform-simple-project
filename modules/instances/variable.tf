variable "security_groups" {
  type = "list"
}

variable "private_subnet_id" {
  type = "string"
}
variable "ami_id" {
  type = "string"
  default = "ami-00035f41c82244dab"
}

variable "public_key_path" {
  type = "string"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  type = "string"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "load_balancers" {
  type = "list"
}

variable "internet_gateway_id" {
  type = "string"
}

variable "target_group_arns" {
  type = "list"
}


