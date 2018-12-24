resource "aws_lb" "http_only" {
  name = "HTTP-Only-LB"
  load_balancer_type = "application"
  subnets         = ["${var.subnets}"]
  security_groups = ["${var.elb_security_groups}"]
}

resource "aws_lb_target_group" "http_target_group" {
  name     = "http-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = "${aws_lb.http_only.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.http_target_group.arn}"
  }
}

