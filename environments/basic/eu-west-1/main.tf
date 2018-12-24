# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "${var.shared_credentials_file_path}"
  profile = "${var.shared_credentials_file_path}"
}

#Creates the VPC, routes, Internet Gateway and 1 public and 1 private subnet
module "network" {
  source = "../../../modules/network"
  vpc_cidr_block = "172.0.0.0/16"
  private_subnet_cidr_block = "172.0.1.0/24"
  public_subnet_cidr_block = "172.0.2.0/24"
}
#Creates Security Groups to allow SSH and HTTP access
module "security_groups" {
  source = "../../../modules/security-groups"
  vpc_id = "${module.network.vpc_id}"
}
#Creates and HTTP Application Load Balancer
module "http_load_balancer" {
  source = "../../../modules/load-balancer/instance"
  elb_security_groups = ["${module.security_groups.internet_http_sg_id}"]
  subnets = ["${module.network.private_subnet_id}", "${module.network.public_subnet_id}"]
  vpc_id = "${module.network.vpc_id}"
}
#Creates Load Balancer listeners rules to allow path bases routing -- This could be taken out to Ansible, but since we are using an AWS LB anyway, for me having it in Terraform is fine as well
module "load_balancer_listeners" {
  source = "../../../modules/load-balancer/listener-rules"
  vpc_id = "${module.network.vpc_id}"
  asg_instances_ids = "${module.instances.asg_instances_ids}"
  load_balancer_listener_arn = "${module.http_load_balancer.load_balancer_listener_arn}"
}

#Creates a Auto-Scaling group with 2 instances
module "instances" {
  source = "../../../modules/instances"
  security_groups = ["${module.security_groups.internal_http_sg_id}", "${module.security_groups.internet_ssh_sg_id}"]
  private_subnet_id = "${module.network.private_subnet_id}"
  ami_id = "${var.default_instances_ami}"
  key_name = "aws_access_key"
  public_key_path = "${var.ssh_public_key_path}"
  target_group_arns = ["${module.http_load_balancer.target_group_arn}"]
  load_balancers = ["${module.http_load_balancer.load_balancer_id}"]
  internet_gateway_id = "${module.network.internet_gateway_id}"
}

#Runs the ansible configuration playbook to install HTTP server (Nginx with PHP-FPM) and upload needed files
resource "null_resource" "cluster" {

  provisioner "local-exec" {
    command     = "ansible-playbook -u root --private-key ${var.ssh_private_key_path} -e 'ansible_python_interpreter=/usr/bin/python3' ${var.ansible_playbook_path} -i ${module.instances.instances_public_ips} "
  }
}