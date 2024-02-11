locals {
  web_servers = {
    instance-01 = {
      machine_type = "t2.micro"
      subnet_id    = aws_subnet.first_public_subnet.id
      name         = "${var.env_name}-first-instance"
    }
    instance-02 = {
      machine_type = "t2.micro"
      subnet_id    = aws_subnet.second_public_subnet.id
      name         = "${var.env_name}-second-instance"
    }
  }
}

data "aws_ami" "aws_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.202*"]
  }
}


resource "aws_instance" "web_servers" {
  for_each = local.web_servers

  ami           = data.aws_ami.aws_linux_ami.id
  instance_type = each.value.machine_type
  subnet_id     = each.value.subnet_id

  vpc_security_group_ids = [aws_security_group.ec2_sg1.id]

  user_data = file(var.httpd_script_path)

  tags = {
    Name        = each.value.name
    Environment = var.env_name
  }
}

