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