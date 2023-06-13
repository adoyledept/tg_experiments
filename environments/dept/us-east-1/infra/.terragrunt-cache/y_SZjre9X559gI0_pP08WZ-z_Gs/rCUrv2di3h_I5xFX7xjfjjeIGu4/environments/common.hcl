# Common configuration variables applicable to all environments (dev, qa)
# Replaces duplicate Terraform locals.tf in all Terraform infrastructure code
locals {
  project_name = "delve"
  app_id       = "infrastructure"

  base_module_source_url = "github.com/delvebio/Infrastructure//tf-modules"
}
