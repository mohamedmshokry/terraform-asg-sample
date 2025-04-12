variable "vpc-name" {
    description = "Name of the VPC"
    type = string
}

variable "vpc-cidr" {
    description = "CIDR of the VPC"
    type = string
}

variable "azs" {
  description = "Availability zones"
  type = list(string)
}

variable "private_subnets" {
  description = "Private subnets"
  type = list(string)
}

variable "public_subnets" {
  description = "Public subnets"
  type = list(string)
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type = bool
}

variable "enable_vpn_gateway" {
  description = "Should be true if you want to provision a VPN Gateway resource"
  type = bool
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type = map(string)
}