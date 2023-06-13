# Configuration variables for the staging region
locals {
  aws_region = "us-east-2"
  cidr       = "172.16.0.0/16"

  # Note that terraform.tfvars cannot interpolate variables so the azs would have
  # hard-coded values, like us-east-2a, us-east-1b, and us-east-1c
  azs            = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]
  public_subnets = ["172.16.0.0/21", "172.16.8.0/21", "172.16.16.0/21"]
}
