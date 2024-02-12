resource "aws_lb" "demo_nlb" {
  name               = "${var.env_name}-demo-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_sg1.id]

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
  load_balancer_arn = aws_lb.demo_nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_target_group.arn
  }
}

resource "aws_lb_target_group" "demo_target_group" {
  name       = "${var.env_name}-lb"
  port       = 80
  protocol   = "TCP"
  vpc_id     = aws_vpc.alb_vpc.id
  slow_start = 0

  health_check {
    enabled             = true
    port                = 80
    interval            = 5
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 2
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
