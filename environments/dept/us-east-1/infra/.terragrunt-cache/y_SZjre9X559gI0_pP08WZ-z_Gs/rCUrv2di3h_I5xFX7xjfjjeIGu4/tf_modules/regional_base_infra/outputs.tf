output "azs" {
  value = module.base_vpc.azs
}

output "igw_id" {
  value = module.base_vpc.igw_id
}

output "igw_arn" {
  value = module.base_vpc.igw_arn
}

output "public_internet_gateway_route_id" {
  value = module.base_vpc.public_internet_gateway_route_id
}

output "public_subnets" {
  value = module.base_vpc.public_subnets
}

output "intra_subnets" {
  value = module.base_vpc.intra_subnets
}

output "public_subnet_arns" {
  value = module.base_vpc.public_subnet_arns
}

output "vpc_id" {
  value = module.base_vpc.vpc_id
}
