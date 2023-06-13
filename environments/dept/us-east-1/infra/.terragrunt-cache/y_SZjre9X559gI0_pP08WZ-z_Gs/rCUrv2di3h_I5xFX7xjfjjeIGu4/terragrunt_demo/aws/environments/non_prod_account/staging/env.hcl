# Configuration variables for the staging environment
# Replaces duplicate Terraform environment terraform.tfvars in all Terraform infrastructure code
# Seeing all the staging environment variables in one place make it easier to
# understand and configure the whole environment
locals {
  environment_name       = "staging"
  terraform_infra_region = "us-east-2"
}