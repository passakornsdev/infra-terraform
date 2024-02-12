resource "aws_subnet" "first_public_subnet" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = var.first_subnet_cidr
  availability_zone       = var.first_az
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.first_az}-first-alb-public-subnet"
    Environment = var.env_name
  }
}

resource "aws_subnet" "second_public_subnet" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = var.second_subnet_cidr
  availability_zone       = var.second_az
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.second_az}-second-alb-public-subnet"
    Environment = var.env_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.alb_vpc.id
  tags = {
    Name        = "${var.env_name}-public-route-table"
    Environment = var.env_name
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_first_subnet" {
  subnet_id      = aws_subnet.first_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_second_subnet" {
  subnet_id      = aws_subnet.second_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
