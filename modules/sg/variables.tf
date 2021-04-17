variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "The security group description. Defaults to \"Managed by Terraform\""
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = null

}

variable "rule_cidr_blocks" {
  description = "List of CIDR blocks"
  type = list(map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })))
  default = []

}

variable "rule_security_group_id" {
  description = "List of security group IDs"
  type = list(map(object({
    type            = string
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
  })))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}

}
