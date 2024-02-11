resource "aws_s3_bucket" "passakorn_bucket" {
  bucket = "${var.envName}-passakorn-bucket"

  tags = {
    Name        = "My bucket"
    Environment = var.envName
  }
}

variable "envName" {}
