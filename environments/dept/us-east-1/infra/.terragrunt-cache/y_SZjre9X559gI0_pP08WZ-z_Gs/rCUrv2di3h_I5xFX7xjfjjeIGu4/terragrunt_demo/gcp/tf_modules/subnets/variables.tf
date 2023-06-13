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

variable "cidr" {
  type = string
}

variable "cidr_proxy" {
  type = string
}

variable "region" {
  type = string
}

