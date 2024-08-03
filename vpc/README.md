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

### Step 2: Configure AWS CLI

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
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Main Configuration (main.tf)

```terraform
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  first_az = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "webserver_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = local.first_az
  map_public_ip_on_launch = true
}

module "webserver" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [data.aws_security_group.default.id]
  subnet_id              = aws_subnet.webserver_subnet.id

  tags = {
    Name = "Webserver"
  }
}
```

## Variables (variables.tf)

```terraform
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key pair name to use for the instance"
  type        = string
}
```

## Outputs (outputs.tf)

```terraform
output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = module.webserver.instance_id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = aws_subnet.webserver_subnet.id
}
```

## Cleaning Up

To destroy the infrastructure created by this project, run:

```sh
terraform destroy
```

Type `yes` when prompted to confirm the destruction.
