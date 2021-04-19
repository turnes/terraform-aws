variable "vpc_id" {
  description = "ID of VPC"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnets IDs"
  type        = list(string)
  default     = []
}

variable "enable_s3_endpoint" {
  description = "Enable or disable s3 endpoint"
  type        = bool
  default     = false
}

variable "s3_private_dns" {
  description = "Use a private dns in this endpoint"
  type        = bool
  default     = false
}

variable "s3_sg_ids" {
  description = "List of Security Groups ids"
  type        = list(string)
  default     = []
}

variable "enable_ecr_dkr_endpoint" {
  description = "Enable or disable ecr dkr endpoint"
  type        = bool
  default     = false
}

variable "ecr_dkr_private_dns" {
  description = "Use a private dns in this endpoint"
  type        = bool
  default     = false
}

variable "ecr_dkr_sg_ids" {
  description = "List of Security Group`s  ids"
  type        = list(string)
  default     = []
}

variable "enable_cloud_watch_endpoint" {
  description = "Enable or disable cloud watch endpoint"
  type        = bool
  default     = false
}

variable "cloud_watch_private_dns" {
  description = "Use a private dns in this endpoint"
  type        = bool
  default     = false
}

variable "cloud_watch_sg_ids" {
  description = "List of Security Group`s  ids"
  type        = list(string)
  default     = []
}

variable "enable_dynamo_db_endpoint" {
  description = "Enable or disable dynamo_db endpoint"
  type        = bool
  default     = false
}

variable "dynamo_db_private_dns" {
  description = "Use a private dns in this endpoint"
  type        = bool
  default     = false
}

variable "dynamo_db_route_table_ids" {
  description = "List of Security Group`s  ids"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "List of tags"
  type        = map(string)
  default     = {}

}