provider "aws" {
  region  = "eu-west-1"
  profile = "roadtoawsdev"
}


module "vpc" {
  source = "./modules/vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  zones           = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = true
  single_nat_gateway   = false
  reuse_nat_ips        = false
  external_nat_ip_ids  = []

  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "sg_alb" {
  source      = "./modules/sg"
  name        = "sg_alb"
  description = "Application Load Balancer SG"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}


module "alb" {
  source = "./modules/elb"
  name   = "my-alb"
  //name_prefix        = 
  internal = false
  type     = "application"
  subnets  = module.vpc.private_subnets

  //enable_deletion_protection = true

  // only valid for Application Load Balancer
  application_security_groups = [module.sg_alb.sg_id]
  idle_timeout                = 60
  // end only valid for Application Load Balancer

  access_logs        = false
  access_logs_bucket = "bkt"
  access_logs_prefix = "my_alb"

  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}