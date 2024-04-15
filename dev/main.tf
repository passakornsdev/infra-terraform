module "alb-with-asg" {
  source = "../modules/alb"
  env_name = "dev"
  first_az = "ap-southeast-1a"
  second_az = "ap-southeast-1b"
  httpd_script_path = "../scripts/install_httpd.sh"
}
