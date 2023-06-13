resource "google_compute_network" "vpc" {
  name                    = "${local.name_prefix}-vpc"
  project                 = data.google_project.project.project_id
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode

  # Google recommends the default MTU of 1460 for GCP VPC
  # because it needs to fit inside the known MTU default of 1500
  mtu                             = 1460
  enable_ula_internal_ipv6        = false
  delete_default_routes_on_create = true
}