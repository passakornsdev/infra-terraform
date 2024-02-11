module "alb-with-asg" {
  source = "../modules/alb-with-asg"
  env_name = "dev"
  first_az = "ap-south-1a"
  second_az = "ap-south-1b"
  httpd_script_path = "../scripts/install_httpd.sh"
}
