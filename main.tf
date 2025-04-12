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
  health_check_type         = var.asg_health_check_type
  vpc_zone_identifier       = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]


  # Launch template
  launch_template_name        = var.asg-lt-details["launch_template_name"]
  launch_template_description = var.asg-lt-details["launch_template_description"]
  update_default_version      = true

  image_id          = var.asg-lt-details["image_id"]
  instance_type     = var.asg-lt-details["instance_type"]
  ebs_optimized     = true
  enable_monitoring = true

  user_data = base64encode(file("install_apache.sh"))

  tags = var.tags
}

################
# Creating ALB
################
module "blog_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.alb-name

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.blog_sg.security_group_id]

  target_groups = [
    {
      name_prefix      = "asg-lt-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "dev"
  }
}

################
# Creating SG
################
module "blog_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  vpc_id  = module.vpc.vpc_id
  name    = "blog"
  ingress_rules = ["https-443-tcp","http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}