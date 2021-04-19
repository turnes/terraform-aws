###
# VPC Endpoints
###
# S3

data "aws_vpc_endpoint_service" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  service      = "s3"
  service_type = "Interface"

}
resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.s3[0].service_name
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.s3_private_dns
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.s3_sg_ids

  tags = merge(
    { Name = "S3 VPC Endpoint Interface" },
    var.tags
  )
}

data "aws_vpc_endpoint_service" "ecr_dkr" {
  count        = var.enable_ecr_dkr_endpoint ? 1 : 0
  service      = "ecr.dkr"
  service_type = "Interface"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  count = var.enable_ecr_dkr_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.ecr_dkr[0].service_name
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.ecr_dkr_private_dns
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.ecr_dkr_sg_ids
  tags = merge(
    { Name = "ECR DKR VPC Endpoint Interface" },
    var.tags
  )


}

data "aws_vpc_endpoint_service" "cloud_watch" {
  count        = var.enable_ecr_dkr_endpoint ? 1 : 0
  service      = "logs"
  service_type = "Interface"
}

resource "aws_vpc_endpoint" "cloud_watch" {
  count = var.enable_cloud_watch_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.cloud_watch[0].service_name
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.cloud_watch_private_dns
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.cloud_watch_sg_ids
  tags = merge(
    { Name = "Cloud Watch VPC Endpoint Interface" },
    var.tags
  )

}

data "aws_vpc_endpoint_service" "dynamo_db" {
  count        = var.enable_ecr_dkr_endpoint ? 1 : 0
  service      = "dynamodb"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "dynamo_db" {
  count = var.enable_dynamo_db_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.dynamo_db[0].service_name
  vpc_endpoint_type = "Gateway"

  private_dns_enabled = var.dynamo_db_private_dns
  route_table_ids     = var.dynamo_db_route_table_ids

  tags = merge(
    { Name = "DynamoDB VPC Endpoint Gateway" },
    var.tags
  )

}