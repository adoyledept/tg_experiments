################################################################################
# VPC Module
################################################################################

module "base_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${local.name_prefix}-vpc"
  cidr = var.cidr

  azs                         = var.azs
  public_subnets              = var.public_subnets
  intra_subnets               = var.intra_subnets
  create_igw                  = var.create_igw
  create_egress_only_igw      = var.create_egress_only_igw
  enable_nat_gateway          = var.enable_nat_gateway
  single_nat_gateway          = var.single_nat_gateway
  one_nat_gateway_per_az      = var.one_nat_gateway_per_az
  intra_dedicated_network_acl = var.intra_dedicated_network_acl
  intra_inbound_acl_rules     = var.intra_inbound_acl_rules
  intra_outbound_acl_rules    = var.intra_outbound_acl_rules

  igw_tags = {
    Name = "${local.name_prefix}-igw"
  }

  public_route_table_tags = {
    Name = "${local.name_prefix}-route-table-public"
  }
}

################################################################################
# VPC Endpoints Module
################################################################################

# Full reference:
# https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete/main.tf#L88

module "base_vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.19.0"

  vpc_id = module.base_vpc.vpc_id
  endpoints = {
    s3 = {
      service = "s3"
      tags    = { Name = "s3-vpc-endpoint" }
    },
  }
}
