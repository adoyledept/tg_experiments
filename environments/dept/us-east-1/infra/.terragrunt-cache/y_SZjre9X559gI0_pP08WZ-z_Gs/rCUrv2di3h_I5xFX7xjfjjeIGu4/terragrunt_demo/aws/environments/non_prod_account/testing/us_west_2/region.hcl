# Configuration variables for the testing region
locals {
  aws_region = "us-west-2"
  cidr       = "192.168.0.0/16"

  # Note that terraform.tfvars cannot interpolate variables so the azs would have
  # hard-coded values, like us-west-2a, us-west-2b, us-west-2c
  azs            = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]
  public_subnets = ["192.168.248.0/21", "192.168.240.0/21", "192.168.232.0/21"]
}
