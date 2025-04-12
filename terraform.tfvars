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
asg-name = "tfcloud-asg"
asg-size = {
  "min_size" = 2,
  "max_size" = 4,
  "desired_capacity" = 2,
  "wait_for_capacity_timeout" = 0,
}

asg_health_check_type = "EC2"

asg-lt-details = {
  "launch_template_name" = "asg-lt-sample",
  "launch_template_description" = "Launch template example",
  "image_id" = "ami-0274f4b62b6ae3bd5",
  "instance_type" = "t3.micro"
}