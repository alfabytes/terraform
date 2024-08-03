provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  # azs = tolist(data.aws_availability_zones.available.names)
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  vpc_cidr = var.vpc_cidr
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${var.project_name}-vpc"

  azs  = local.azs
  # azs = data.aws_availability_zones.available.names

  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 100)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

  tags = var.tags
}