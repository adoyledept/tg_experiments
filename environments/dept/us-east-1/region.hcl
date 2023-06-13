locals {
  # Local region 
  aws_region = "us-east-1"
  
  # VPC Module Variables
  cidr       = "10.7.0.0/20"
  azs        = [
    "${local.aws_region}a",
    "${local.aws_region}b", 
    "${local.aws_region}c",
    "${local.aws_region}d",
    "${local.aws_region}e", 
    "${local.aws_region}f"
  ]
  public_subnets = [
    "10.7.0.0/25",
    "10.7.0.128/25"
  ]  
  intra_subnets = [
    "10.7.1.0/25",
    "10.7.1.128/25"
  ]
  private_subnets = [
    "10.7.2.0/23",
    "10.7.4.0/23",
    "10.7.6.0/23",
    "10.7.8.0/23",
    "10.7.10.0/23",
    "10.7.12.0/23"
  ]

  # Future module variables
}