variable "environment_name" {
  type        = string
  description = "Name of environment"
}

variable "app_id" {
  type        = string
  description = "Name of application"
}

variable "azs" {
  type        = list(string)
  description = "The Availability Zones of the deployment"
}

variable "cidr" {
  type        = string
  description = "The IPv4 CIDR of the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "The IPv4 public subnets for aws_cidr"
  default     = []
}

# https://github.com/terraform-aws-modules/terraform-aws-vpc#private-versus-intra-subnets

variable "intra_subnets" {
  type        = list(string)
  description = "The IPv4 intra subnets (no external routing) for aws_cidr"
  default     = []
}

variable "create_igw" {
  type    = bool
  default = true
}

variable "create_egress_only_igw" {
  type    = bool
  default = false
}

# https://github.com/terraform-aws-modules/terraform-aws-vpc#nat-gateway-scenarios

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

variable "one_nat_gateway_per_az" {
  type    = bool
  default = false
}

# https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/variables.tf#L382

variable "intra_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for private subnets"
  type        = bool
  default     = false
}

variable "intra_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "intra_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "intra_acl_tags" {
  description = "Additional tags for the private subnets network ACL"
  type        = map(string)
  default     = {}
}
