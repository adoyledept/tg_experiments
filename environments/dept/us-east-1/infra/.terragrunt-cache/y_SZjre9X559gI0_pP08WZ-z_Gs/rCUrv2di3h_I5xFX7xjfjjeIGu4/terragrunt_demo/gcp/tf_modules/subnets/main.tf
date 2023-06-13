resource "google_compute_subnetwork" "subnet" {
  project       = data.google_project.project.project_id
  name          = "${local.name_prefix}-subnet-${var.region}"
  network       = data.google_compute_network.vpc.name
  ip_cidr_range = var.cidr
  region        = var.region
  purpose       = "PRIVATE"
}

resource "google_compute_subnetwork" "subnet_proxy" {
  project       = data.google_project.project.project_id
  name          = "${local.name_prefix}-subnet-proxy-${var.region}"
  network       = data.google_compute_network.vpc.name
  ip_cidr_range = var.cidr_proxy
  region        = var.region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}