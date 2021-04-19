resource "aws_api_gateway_vpc_link" "this" {
  name        = "vpc-link-${var.name}"
  target_arns = [var.alb_arn]
}


resource "aws_api_gateway_rest_api" "this" {
  name = "api-gateway-${var.name}"
}


resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = var.path_part
}
resource "aws_api_gateway_method" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = var.http_method
  authorization = var.authorization

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
  type                    = var.integration_input_type
  uri                     = "http://${var.alb_dns}:${var.app_port}/{proxy}"
  integration_http_method = var.integration_http_method
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.this.id
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  depends_on  = [aws_api_gateway_integration.this]
  variables = {
    # just to trigger redeploy on resource changes
    resources = join(", ", [aws_api_gateway_resource.this.id])
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage
}