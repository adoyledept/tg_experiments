# Configuration variables for the development environment
# Replaces duplicate Terraform environment terraform.tfvars in all Terraform infrastructure code
# Seeing all the development environment variables in one place make it easier to
# understand and configure the whole environment
locals {
  ## TODO : Replace with GCP Project
  gcp_project_id         = "xxxx-xxxx-xxxx"
  environment_name       = "testing"
  terraform_infra_region = "us-east1"
}