resource "aws_s3_bucket" "passakorn_bucket" {
  bucket = "${var.env_name}-passakorn-bucket"

  tags = {
    Name        = "My bucket"
    Environment = var.env_name
  }
}

variable "env_name" {}
