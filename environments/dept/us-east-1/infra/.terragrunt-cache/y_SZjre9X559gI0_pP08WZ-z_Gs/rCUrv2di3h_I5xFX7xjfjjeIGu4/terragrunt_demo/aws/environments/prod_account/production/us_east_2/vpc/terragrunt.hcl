# Includes the root terragrunt.hcl configurations
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component.
# The _envcommon/vpc.hcl file contains VPC configurations
# that are common across all production environments (production, failover).
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/vpc.hcl"
  expose = true
}