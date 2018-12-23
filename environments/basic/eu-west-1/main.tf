# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

module "network" {
  source = "../../../modules/network"
  vpc_cidr_block = "172.0.0.0/16"
  private_subnet_cidr_block = "172.0.1.0/24"
  public_subnet_cidr_block = "172.0.2.0/24"
}

module "security_groups" {
  source = "../../../modules/security-groups"
  vpc_id = "${module.network.vpc_id}"
}

module "http_load_balancer" {
  source = "../../../modules/load-balancer"
  elb_security_groups = ["${module.security_groups.internet_http_sg_id}"]
  subnets = ["${module.network.private_subnet_id}"]
}

module "instances" {
  source = "../../../modules/instances"
  security_groups = ["${module.security_groups.internal_http_sg_id}", "${module.security_groups.internet_ssh_sg_id}"]
  private_subnet_id = "${module.network.private_subnet_id}"
  ami_id = "123"
  key_name = "instance_private_key"
  public_key_path = "../../../instance_private_key.pem"
}

