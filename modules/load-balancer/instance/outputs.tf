output "load_balancer_id" {
  value = "${aws_lb.http_only.id}"
}
output "target_group_arn" {
  value = "${aws_lb_target_group.http_target_group.arn}"
}
output "load_balancer_listener_arn" {
  value = "${aws_lb_listener.default.arn}"
}