# The root terragrunt.hcl containing the configuration applicable
# to all non-prod accounts and environments (development, testing, staging)

# Locals are named constants that are reusable within the configuration.
# Loading the common, environment, and region variables
locals {
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

  # Define as Terragrunt local vars to make it easier to use and change
  gcp_project_id         = local.merged_local_vars.gcp_project_id
  project_name           = local.merged_local_vars.project_name
  app_id                 = local.merged_local_vars.app_id
  environment_name       = local.merged_local_vars.environment_name
  terraform_infra_region = local.merged_local_vars.terraform_infra_region
}

# Using the common, env, and region variables as input for the Terraform modules
# Replaces duplicate terraform.tfvars files and Terraform modules configuration
inputs = local.merged_local_vars

# Common Terraform remote state that can be reused by all modules
# Replaces duplicate providers.tf terraform backend
remote_state {
  backend = "gcs"

  # If the GCP Terraform resource does not exist, Terragrunt will create it.
  # Notice you can use Terragrunt local variables in the backend config.
  # In Terraform, variable usage is not allowed in the backend config.
  #
  # In Terragrunt, the path_relative_to_include() function can ensure that the backed key is dynamic.
  # In Terraform, the unique backend key must be hard-coded for each configuration.
  config = {
    project = local.gcp_project_id
    bucket  = "${local.environment_name}-${local.app_id}-tfstate"
    location  = local.terraform_infra_region
    prefix  = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "terragrunt-generated-backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate an AWS provider block
# In Terraform, changing these provider settings and versions results in changing multiple providers.tf
# In Terragrunt, this root terragrunt.hcl is the only place you need to make the change
generate "provider" {
  # This is using the Terraform built-in override file functionality
  # https://www.terraform.io/language/files/override
  path      = "providers_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
# In a professional setting, a hard-pin of terraform versions ensures all
# team members use the same version, reducing state conflict
terraform {
  required_version = "1.4.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.58.0"
    }
  }
}
provider "google" {
  project = "${local.gcp_project_id}"
}

provider "google-beta" {
  project = "${local.gcp_project_id}"
}

EOF
}

terraform {
  # Terragrunt extra_arguments sets Terraform options in one place
  # To do this in Terraform would require a custom bash script

  # Force Terraform to run with increased parallelism
  extra_arguments "parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=15"]
  }
  # Force Terraform to keep trying to acquire a lock for up to 3 minutes if someone else already has the lock
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=3m"]
  }

  # Hooks are external programs that will run before, after, or on error Terragrunt execution
  # In the real world, you can use before,after,error hooks to post on Slack or CloudWatch to
  # monitor environment changes
  before_hook "before_plan_apply_hook" {
    commands = ["plan", "apply"]
    execute  = ["echo", "START Delve.bio non-prod Terragrunt execution"]
  }
  after_hook "after_plan_apply_hook" {
    commands = ["plan", "apply"]
    execute  = ["echo", "FINISH Delve.bio non-prod Terragrunt execution"]
  }

  before_hook "before_destroy_hook" {
    commands = ["destroy"]
    execute  = ["echo", "START Delve.bio non-prod Terragrunt destroy"]
  }
  after_hook "after_destroy_hook" {
    commands = ["destroy"]
    execute  = ["echo", "FINISH Delve.bio non-prod Terragrunt destroy"]
  }

  error_hook "on_error_hook" {
    commands = ["plan", "apply", "destroy"]
    execute  = ["echo", "ERROR running Terragrunt"]
    on_errors = [
      ".*",
    ]
  }

}

# Terragrunt will automatically retry the underlying Terraform commands if it fails
# You can configure custom errors to retry in the retryable_errors list
# and you can specify how ofter the retries occur
//retryable_errors = [
//  "(?s).*Error installing provider.*tcp.*connection reset by peer.*",
//  "(?s).*ssh_exchange_identification.*Connection closed by remote host.*"
//]
retry_max_attempts       = 3
retry_sleep_interval_sec = 5
