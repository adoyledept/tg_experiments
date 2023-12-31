# Configuration variables for the production environment
# Replaces duplicate Terraform environment terraform.tfvars in all Terraform infrastructure code
# Seeing all the production environment variables in one place make it easier to
# understand and configure the whole environment
locals {
  environment_name       = "production"
  terraform_infra_region = "us-east-2"
}