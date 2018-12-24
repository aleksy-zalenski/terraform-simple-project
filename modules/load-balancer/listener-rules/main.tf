resource "aws_lb_target_group" "target_group_boxA" {
  name     = "target-group-boxA"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = "${var.vpc_id}"
}

resource "aws_lb_target_group_attachment" "attachment_group_boxA" {
  target_group_arn = "${aws_lb_target_group.target_group_boxA.arn}"
  target_id        = "${var.asg_instances_ids[0]}"
  port             = 80
}

resource "aws_lb_target_group" "target_group_boxB" {
  name     = "target-group-boxB"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group_attachment" "attachment_group_boxB" {
  target_group_arn = "${aws_lb_target_group.target_group_boxB.arn}"
  target_id        = "${var.asg_instances_ids[1]}"
  port             = 80
}

resource "aws_lb_listener_rule" "about-path-box-a" {
  listener_arn = "${var.load_balancer_listener_arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group_boxA.arn}"
  }
  condition {
    field  = "path-pattern"
    values = ["/about.php*"]
  }
}

resource "aws_lb_listener_rule" "contact-path-box-b" {
  listener_arn = "${var.load_balancer_listener_arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group_boxB.arn}"
  }
  condition {
    field  = "path-pattern"
    values = ["/contact.php*"]
  }
}


