output "internet_http_sg_id" {
  value = "${aws_security_group.http_only_access_from_internet.id}"
}

output "internet_ssh_sg_id" {
  value = "${aws_security_group.internet_ssh_access.id}"
}

output "internal_http_sg_id" {
  value = "${aws_security_group.http_only_access_from_vpc.id}"
}