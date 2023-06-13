# This is the common component configuration for vpc in production environments (production, failover).

# Locals are named constants that are reusable within the configuration.
locals {
  # Unfortunately a bit of duplication with the root terragrunt.hcl locals
  # since Terragrunt does not let an "include" file access another "include" file
  # Automatically load and merge config
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  # Automatically load environment scoped variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load AWS region scoped variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Merge all the variables to allow overriding local variables
  merged_local_vars = merge(
    local.common_vars.locals,
    local.env_vars.locals,
    local.region_vars.locals
  )

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child Terragrunt configurations.
  base_module_source_url = local.merged_local_vars.base_module_source_url
  module_name            = "base_vpc"
  module_source_url      = "${local.base_module_source_url}/${local.module_name}"
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
  # For prod, we want to use Terraform modules tested in non-prod and committed into git
  # If we need to override and use local directories for Terraform modules,
  # use the following command line
  # terragrunt apply --terragrunt-source=../../../../..//tf_modules/base_vpc
  # source = "../../../../..//tf_modules/${local.module_name}"
  source = "${local.module_source_url}?ref=main"
}
