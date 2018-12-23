resource "aws_elb" "http_only" {
  name = "HTTP-Only ELB"

  subnets         = ["${}"]
  security_groups = ["${var.elb_security_groups}"]
  instances       = ["${aws_instance.web.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
