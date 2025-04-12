########################################
# Ceating VPC, subnet, NAT GW and IGW
########################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc-name
  cidr = var.vpc-cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = var.tags
}

################
# Creating ASG
################
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = var.asg-name

  min_size                  = var.asg-size["min_size"]
  max_size                  = var.asg-size["max_size"]
  desired_capacity          = var.asg-size["desired_capacity"]
  wait_for_capacity_timeout = var.asg-size["wait_for_capacity_timeout"]
  health_check_type         = var.asg-size["health_check_type"]
  vpc_zone_identifier       = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]


  # Launch template
  launch_template_name        = var.asg-lt-details["launch_template_name"]
  launch_template_description = var.asg-lt-details["launch_template_description"]
  update_default_version      = true

  image_id          = var.asg-lt-details["image_id"]
  instance_type     = var.asg-lt-details["instance_type"]
  ebs_optimized     = true
  enable_monitoring = true

  tags = var.tags
}