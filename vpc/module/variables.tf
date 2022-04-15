variable "region" {
  type        = string
  description = "Name of the AWS region to deploy VPC into"
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "example-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR address for the VPC"
  default     = "10.0.0.0/16"
}

#variable "private_subnets" {
# type        = list(string)
#  description = "List of private subnets to create within the VPC"
#  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether or not to enable a NAT gateway for the private subnets"
  default     = true
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "Whether or not to enable a VPN gateway"
  default     = false
}

variable "private_subnet_count" {
  type        = number 
  description = "Numbers of private subnet "
  default     = false
}

#variable "azs" {
#  type        = list(string)
#  description = "List of azs"
 # default     = ["${var.region}a", "${var.region}b"]
#}

variable "cidr_ab" {
    type = map
    default = {
        development     = "172.22"
    }
}

locals {
    cidr_c_private_subnets  = 1

    max_private_subnets     = var.private_subnet_count
}

data "aws_availability_zones" "available" {
    state = "available"
}

locals {
    availability_zones = data.aws_availability_zones.available.names
}

variable "environment" {
    type = string
    description = "Options: development"
}

#locals {
#    private_subnets = [
#        for az in local.availability_zones : 
#            "172.22.${local.cidr_c_private_subnets + index(local.availability_zones, az)}.0/24"
#            if index(local.availability_zones, az) < local.max_private_subnets
#        ]
#}

locals {
   subnet_count = var.subnet_count >= 2 ? var.subnet_count : length(data.aws_availability_zones.all.names)
}
