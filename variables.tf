variable "AWS_ACCESS_KEY_ID" {
  description = "AWS_ACCESS_KEY_ID"
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS_SECRET_ACCESS_KEY"
  type = string
}
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

variable "asg-name" {
  description = "Name of the ASG"
  type = string
}

variable "asg-size" {
  description = "Size of the ASG"
  type = map(number)
}

variable "asg-lt-details" {
  description = "Details of the launch template"
  type = map(string)
}