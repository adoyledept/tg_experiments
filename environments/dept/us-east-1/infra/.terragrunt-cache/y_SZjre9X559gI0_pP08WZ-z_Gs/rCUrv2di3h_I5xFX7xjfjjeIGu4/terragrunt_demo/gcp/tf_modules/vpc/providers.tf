# This is the minimum Terraform versions that this module was tested against
terraform {
  required_version = "~> 1.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0, < 5.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.51, < 5.0"
    }
  }
}
