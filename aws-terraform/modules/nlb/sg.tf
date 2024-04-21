resource "aws_security_group" "ec2_sg1" {
  name   = "${var.env_name}-ec2-sg1"
  vpc_id = aws_vpc.alb_vpc.id

  tags = {
    Environment = var.env_name
  }
}

resource "aws_security_group" "nlb_sg1" {
  name   = "${var.env_name}-alb-sg1"
  vpc_id = aws_vpc.alb_vpc.id

  tags = {
    Environment = var.env_name
  }
}

resource "aws_security_group_rule" "ingress_ec2_traffic" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg1.id
  source_security_group_id = aws_security_group.nlb_sg1.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_all_ipv4" {
  security_group_id = aws_security_group.nlb_sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_alb_sg" {
  security_group_id = aws_security_group.nlb_sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_ec2_sg" {
  security_group_id = aws_security_group.ec2_sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
