# Terraform AWS EC2 Project

This Terraform project creates an AWS EC2 along with associated resources such as VPC and security groups.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- AWS account with appropriate permissions.
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured.

## Project Structure

```bash
.
├── key-pair.tf
├── main.tf
├── provider.tf
├── security-groups.tf
├── variables.tf
└── README.md
```

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

### Cleaning Up

To destroy the infrastructure created by this project, run:

```sh
terraform destroy
```

Type `yes` when prompted to confirm the destruction.
