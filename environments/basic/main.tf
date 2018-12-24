module "eu-west-1" {
  source = "eu-west-1"
  aws_region = "eu-west-1"
  shared_credentials_file_path = "${var.shared_credentials_file_path}"
  shared_credentials_profile = "${var.shared_credentials_profile}"
  ssh_private_key_path = "${var.ssh_private_key_path}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
}

variable "ssh_public_key_path" {
  type = "string"
}

variable "ssh_private_key_path" {
  type = "string"
}

variable "shared_credentials_file_path" {
  type = "string"
}

variable "shared_credentials_profile" {
  type = "string"
}