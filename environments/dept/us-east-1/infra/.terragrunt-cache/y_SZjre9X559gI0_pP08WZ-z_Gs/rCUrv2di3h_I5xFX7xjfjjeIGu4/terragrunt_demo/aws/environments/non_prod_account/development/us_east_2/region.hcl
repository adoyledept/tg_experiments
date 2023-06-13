# Configuration variables for the development region
locals {
  aws_region = "us-east-2"
  cidr       = "192.168.0.0/16"

  # Note that terraform.tfvars cannot interpolate variables so the azs would have
  # hard-coded values, like us-east-2a, us-east-2b, us-east-2c
  azs            = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]
  public_subnets = ["192.168.0.0/21", "192.168.8.0/21", "192.168.16.0/21"]
}
