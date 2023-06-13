# Common configuration variables applicable to all environments (dev, qa)
# Replaces duplicate Terraform locals.tf in all Terraform infrastructure code
locals {
  project_name = "delve.bio"
  app_id       = "delve-product"

  base_module_source_url = "github.com/delvebio/Infrastructure//aws/tf-modules"
}