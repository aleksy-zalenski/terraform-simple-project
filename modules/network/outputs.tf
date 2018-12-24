output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.default.id}"
}