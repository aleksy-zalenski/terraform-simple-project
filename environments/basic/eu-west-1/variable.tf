variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
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

variable "ansible_playbook_path" {
  type = "string"
  default = "/home/aleksy/Private/codete-devops-task/environments/basic/eu-west-1/configuration/playbook.yml"
}

variable "default_instances_ami" {
  type = "string"
  default = "ami-00035f41c82244dab"
}
