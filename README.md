# Infrastructure with Terraform

## Description
Explore services and features on AWS, learning and create architecture with Terraform.

## Prerequisite
Terraform Installation - [Download Terraform](https://developer.hashicorp.com/terraform/install)

AWS Account or other provider (Azure, GCP, etc.) - [AWS](https://aws.amazon.com/free/?gclid=CjwKCAiA_aGuBhACEiwAly57MdZgxo8f8Q9Ekbc_WfkQEEl_iGLpylxCS9LajskE-178iyMYK-Oj1xoCrNIQAvD_BwE&trk=c4f45c53-585c-4b31-8fbf-d39fbcdc603a&sc_channel=ps&ef_id=CjwKCAiA_aGuBhACEiwAly57MdZgxo8f8Q9Ekbc_WfkQEEl_iGLpylxCS9LajskE-178iyMYK-Oj1xoCrNIQAvD_BwE:G:s&s_kwcid=AL!4422!3!637354294239!e!!g!!aws!19043613274!143453611386)

AWS Access Key - To Generate Access Key, browse to the IAM section in the AWS console and 'create new access key' and select "Third-party service" option.


## Usage Instructions
The list down steps below are general guide how to get start with this repo and terraform


### 1. Choose Environment
You can choose environment to work with by navigate terminal to that directory and follow steps below


### 2. Set up Credential
You could create provider.tf file like below with credential.

Or you could use "aws configure" command to set up AWS credential and exclude credential from provider.tf, in case you use AWS

```terraform
provider "aws" {
  region     = "ap-south-1"
  access_key = "${access_key}"
  secret_key = "${secrey_key}"
}
```

### 3. Select ENV
For ENV I would suggest to use dev by navigate terminal to ./dev (although it is not much different just the name of each instances when they are created)

### 4. Select Module to start with
You could check out README on each directory under ./modules for more information and decide which module do you want to try.

Then you update main.tf (as example below) to load your desired module and then start building infrastructure.

```terraform
module "alb-with-asg" {
  source = "../modules/alb"
  env_name = "dev"
}
```

### 3. Initialize Terraform
Then run Terraform init command to establish workspace with setup provider
```shell
terraform init
```


### 3. Basic usages
After successfully initialized Terraform, you can run plan to view on request resources
```shell
terraform plan
```

Then you could run apply to created resources
```shell
terraform apply --auto-approve
```

Everytime you modify loaded module in main.tf, you need to run Terraform init command again

### 4. Clean up
To clean up resources, simply run destroy command, then Terraform will automatically remove all relevant resource to this module
```shell
terraform destroy
```
