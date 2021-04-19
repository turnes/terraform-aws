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
  single_nat_gateway   = true
  reuse_nat_ips        = false
  external_nat_ip_ids  = []
  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}


module "sg_ecs_tasks" {
  source      = "./modules/sg"
  name        = "sg_ecs_tasks"
  description = "Application Load Balancer SG"
  vpc_id      = module.vpc.vpc_id

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

module "vpc_endpoints" {
  source = "./modules/vpc_endpoint"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  ## S3
  enable_s3_endpoint = true
  s3_private_dns     = false
  s3_sg_ids          = [module.sg_ecs_tasks.sg_id]
  ## ECR
  enable_ecr_dkr_endpoint = true
  ecr_dkr_private_dns     = true
  ecr_dkr_sg_ids          = [module.sg_ecs_tasks.sg_id]
  ## Cloud Watch
  enable_cloud_watch_endpoint = true
  cloud_watch_private_dns     = true
  cloud_watch_sg_ids          = [module.sg_ecs_tasks.sg_id]
  ## DynamoDB
  enable_dynamo_db_endpoint = true
  dynamo_db_private_dns     = false
  dynamo_db_route_table_ids = module.vpc.private_route_tables

  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ecs_cluster" {
  source = "./modules/ecs-fargate/cluster"

  name = "my_cluster"
  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}


module "alb" {
  source = "./modules/elb"
  name   = "my-nlb"
  //name_prefix        = 
  internal = true
  type     = "network"
  subnets  = module.vpc.private_subnets

  //enable_deletion_protection = true

  // only valid for Application Load Balancer
  # application_security_groups = [module.sg_alb.sg_id]
  # idle_timeout                = 60
  // end only valid for Application Load Balancer

  # access_logs        = false
  # access_logs_bucket = "bkt"
  # access_logs_prefix = "my_alb"
  vpc_id = module.vpc.vpc_id
  target_groups = [
    {
      name = "basic-api-service"
      port = 8080
    }
  ]

  listener = [
    {
      port     = 8080
      protocol = "TCP"
      type     = "forward"
    }
  ]

  tags = {
    Owner       = "Team A"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ecs_task_a" {
  source                     = "./modules/ecs-fargate"
  name                       = "basic-api"
  task_role_policy_file_path = "./tasks/basic-api/aws_iam_role_policy.json"
  cpu                        = 512
  memory                     = 1024
  c_name                     = "My_container"
  c_image                    = "903623081390.dkr.ecr.eu-west-1.amazonaws.com/rafael/express-test:latest"
  c_port                     = 8080

  #service
  cluster_id          = module.ecs_cluster.cluster_id
  target_groups       = module.alb.target_group_arn
  desired_count       = 2
  security_groups_ids = [module.sg_ecs_tasks.sg_id]
  private_subnets_ids = module.vpc.private_subnets

}

module "api-gateway" {
  source = "./modules/api-gateway"

  name          = "my-api-gw"
  alb_arn       = module.alb.alb_arn
  path_part     = "{proxy+}"
  http_method   = "ANY"
  authorization = "NONE"

  integration_input_type  = "HTTP_PROXY"
  alb_dns                 = module.alb.alb_dns
  app_port                = 8080
  integration_http_method = "ANY"
  stage                   = "dev"
}




