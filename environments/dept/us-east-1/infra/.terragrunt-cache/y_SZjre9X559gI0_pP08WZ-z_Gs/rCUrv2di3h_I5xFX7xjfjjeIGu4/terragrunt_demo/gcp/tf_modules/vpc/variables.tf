variable "gcp_project_id" {
  type = string
}

variable "environment_name" {
  type        = string
  description = "Name of environment"
}

variable "app_id" {
  type        = string
  description = "Name of application"
}

variable "routing_mode" {
  type        = string
  description = "The network-wide routing mode to use.  Possible values are REGIONAL and GLOBAL."
  default     = "REGIONAL"
}