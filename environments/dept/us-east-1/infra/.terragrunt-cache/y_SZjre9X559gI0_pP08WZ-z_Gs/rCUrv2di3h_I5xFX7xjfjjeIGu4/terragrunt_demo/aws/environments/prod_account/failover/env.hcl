# Configuration variables for the failover environment
# Replaces duplicate Terraform environment terraform.tfvars in all Terraform infrastructure code
# Seeing all the failover environment variables in one place make it easier to
# understand and configure the whole environment
locals {
  environment_name       = "failover"
  terraform_infra_region = "us-west-2"
}