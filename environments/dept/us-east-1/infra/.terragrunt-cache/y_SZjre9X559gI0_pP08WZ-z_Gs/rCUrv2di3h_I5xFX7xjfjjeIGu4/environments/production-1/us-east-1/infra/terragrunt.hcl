# Includes the root terragrunt.hcl configurations
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component.
# The _envcommon/vpc.hcl file contains VPC configurations
# that are common across all non-prod environments (development, testing, staging).
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/regional_base_infra.hcl"
  expose = true
}