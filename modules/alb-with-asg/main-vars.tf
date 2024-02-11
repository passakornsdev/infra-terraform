variable "env_name" {}
variable "first_az" {}
variable "second_az" {}
variable "httpd_script_path" {}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "first_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "second_subnet_cidr" {
  default = "10.0.1.0/24"
}
