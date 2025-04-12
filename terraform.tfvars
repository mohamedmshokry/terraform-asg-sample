vpc-name = "asg-vpc"
vpc-cidr = "11.0.0.0/16"
azs = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
private_subnets = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
public_subnets = ["11.0.101.0/24", "11.0.102.0/24", "11.0.103.0/24"]
enable_nat_gateway = true
enable_vpn_gateway = false
tags = {
    Terraform = "true"
    Environment = "dev"
}