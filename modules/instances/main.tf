resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file("${var.public_key_path}")}"
}

resource "aws_launch_configuration" "launch_configuration" {
  name_prefix   = "default_launchconfig"
  image_id      = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.auth.key_name}"
  associate_public_ip_address = true
  security_groups = ["${var.security_groups}"]
}

resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"

  target_group_arns = ["${var.target_group_arns}"]
  vpc_zone_identifier = ["${var.private_subnet_id}"]

  tag {
    key                 = "http_server"
    value               = "true"
    propagate_at_launch = true
  }
  #depends_on = ["${var.internet_gateway_id}"]
}
