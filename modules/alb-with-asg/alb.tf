resource "aws_lb" "demo_alb" {
  name               = "${var.env_name}-demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg1.id]

  subnets = [
    aws_subnet.first_public_subnet.id,
    aws_subnet.second_public_subnet.id
  ]

  tags = {
    Name        = "${var.second_az}-demo-alb"
    Environment = var.env_name
  }
}

resource "aws_lb_listener" "demo_lb_listener" {
  load_balancer_arn = aws_lb.demo_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_target_group.arn
  }
}

resource "aws_lb_target_group" "demo_target_group" {
  name       = "${var.env_name}-lb"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.alb_vpc.id
  slow_start = 0

  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  health_check {
    enabled             = true
    port                = 80
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Environment = var.env_name
  }
}

resource "aws_lb_target_group_attachment" "demo_target_group_attachment" {
  for_each = aws_instance.web_servers

  target_group_arn = aws_lb_target_group.demo_target_group.arn
  target_id        = each.value.id
  port             = 80
}
