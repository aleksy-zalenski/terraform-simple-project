data "aws_instances" "instances" {
  depends_on = [ "aws_autoscaling_group.autoscaling_group" ]
  instance_tags {
    http_server = "true"
  }
}
#Here there is a little hack done to allow passing IP's to Ansible
output "instances_public_ips" {
  value = "${join(",", data.aws_instances.instances.public_ips)}"
}

output "asg_instances_ids" {
  value = "${data.aws_instances.instances.ids}"
}