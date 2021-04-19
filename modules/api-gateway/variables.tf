variable "name" {
  description = "Identifier"
  type        = string
  default     = null
}

variable "alb_arn" {
  description = "ARN of a load balancer"
  type        = string
  default     = null
}

variable "path_part" {
  description = "The last path segment of this API resource"
  type        = string
  default     = null
}

variable "http_method" {
  description = "The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)"
  type        = string
  default     = null
}

variable "authorization" {
  description = "The type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)"
  type        = string
  default     = null
}

variable "integration_input_type" {
  description = "The integration input's type."
  # Valid values are HTTP (for HTTP backends),
  # MOCK (not calling any real backend), AWS (for AWS services), 
  # AWS_PROXY (for Lambda proxy integration) and HTTP_PROXY (for HTTP proxy integration). 
  # An HTTP or HTTP_PROXY integration with a connection_type of VPC_LINK is referred to as a private integration and uses a VpcLink to connect API Gateway to a network load balancer of a VPC.    
  type    = string
  default = null
}

variable "alb_dns" {
  description = "URI url"
  type        = string
  default     = null
}


variable "app_port" {
  description = "URI port"
  type        = number
  default     = null
}

variable "integration_http_method" {
  type        = string
  default     = "ANY"
  description = "The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end."
}

variable "stage" {
  description = "Name of the stage to create with this deployment. "
  type        = string
  default     = null
}