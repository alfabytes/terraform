# Terraform AWS VPC Project

This Terraform project creates an AWS VPC along with associated resources such as subnets and security groups.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- AWS account with appropriate permissions.
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured.

## Setup

### Step 1: Configure AWS CLI

Configure your AWS CLI with your credentials and default region:

```bash
aws configure
```

### Step 2: Initialize Terraform

Navigate to the project directory and initialize Terraform:

```bash
terraform init
```

This command will download the necessary provider plugins and prepare your working directory for other Terraform commands.

### Step 3: Plan the Infrastructure

Generate and review the execution plan for your Terraform configuration:

```bash
terraform plan
```

This command shows the changes that will be made to your infrastructure.

### Step 4: Apply the Configuration

Apply the Terraform configuration to create the infrastructure:

```bash
terraform apply
```

Type `yes` when prompted to confirm the changes.

## Project Structure

```bash
.
├── provider.tf
├── main.tf
├── variables.tf
└── README.md
```

## Provider (provider.tf)

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.54.0"
    }
  }
}

provider "aws" {
  region = var.region
}
```

## Main Configuration (main.tf)

```terraform
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
```

## Variables (variables.tf)

```terraform
variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  default = "roro-jongrang"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}
variable "tags" {
  description = "Tags for the resources"
  type = map(string)
  default = {
    Project = "roro-jongrang"
  }
}
```

## Cleaning Up

To destroy the infrastructure created by this project, run:

```sh
terraform destroy
```

Type `yes` when prompted to confirm the destruction.
