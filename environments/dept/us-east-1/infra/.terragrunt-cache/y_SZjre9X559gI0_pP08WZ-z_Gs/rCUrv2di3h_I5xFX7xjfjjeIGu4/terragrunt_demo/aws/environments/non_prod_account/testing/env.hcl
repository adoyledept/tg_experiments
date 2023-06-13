# Configuration variables for the testing environment
# Replaces duplicate Terraform environment terraform.tfvars in all Terraform infrastructure code
# Seeing all the testing environment variables in one place make it easier to
# understand and configure the whole environment
locals {
  environment_name       = "testing"
  terraform_infra_region = "us-west-2"
}