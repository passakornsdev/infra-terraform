# Infrastructure with Terraform

## Description
Explore services and features on AWS with Terraform

## Prerequisite
Terraform Installation - [Download Terraform](https://developer.hashicorp.com/terraform/install)

AWS Account or other provider (Azure, GCP, etc.) - [AWS](https://aws.amazon.com/free/?gclid=CjwKCAiA_aGuBhACEiwAly57MdZgxo8f8Q9Ekbc_WfkQEEl_iGLpylxCS9LajskE-178iyMYK-Oj1xoCrNIQAvD_BwE&trk=c4f45c53-585c-4b31-8fbf-d39fbcdc603a&sc_channel=ps&ef_id=CjwKCAiA_aGuBhACEiwAly57MdZgxo8f8Q9Ekbc_WfkQEEl_iGLpylxCS9LajskE-178iyMYK-Oj1xoCrNIQAvD_BwE:G:s&s_kwcid=AL!4422!3!637354294239!e!!g!!aws!19043613274!143453611386)

AWS Access Key - To Generate Access Key, browse to the IAM section in the AWS console and 'create new access key' and select "Third-party service" option.


## Usage Instructions
The list down steps below are general guide how to get start with this repo and terraform


### 1. Choose Environment
You can choose environment to work with by navigate terminal to that directory and follow steps below


### 2. Initialize Terraform
You could create provider.tf file like below with credential.

Or you could use "aws configure" command to set up AWS credential and exclude credential from provider.tf, in case you use AWS

```
provider "aws" {
  region     = "ap-south-1"
  access_key = "${access_key}"
  secret_key = "${secrey_key}"
}
```


### 3. Basic usages
After successfully initialized terraform, you can run plan to view on request resources
```
terraform plan
```

Then you could run apply to created resources
```
terraform apply --auto-approve
```

### 4. Clean up
To clean up resources, simply run destroy command, then Terraform will automatically remove all relevant resource to this module
```
terraform destroy
```
