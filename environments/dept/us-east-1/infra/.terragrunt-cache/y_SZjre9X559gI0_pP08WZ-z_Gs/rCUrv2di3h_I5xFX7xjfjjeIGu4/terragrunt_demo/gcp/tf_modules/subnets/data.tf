data "google_project" "project" {
  project_id = var.gcp_project_id
}

data "google_compute_network" "vpc" {
  name = "${local.name_prefix}-vpc"
}