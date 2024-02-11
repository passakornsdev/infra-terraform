resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.alb_vpc.id
  tags = {
    Name        = "${var.env_name}-igw"
    Environment = var.env_name
  }
}
