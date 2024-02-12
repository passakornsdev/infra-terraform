resource "aws_vpc" "alb_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.env_name}-alb-vpc"
    Environment = var.env_name
  }
}
