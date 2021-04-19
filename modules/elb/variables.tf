variable "name" {
  description = "Identifier. can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen"
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = null

}

variable "internal" {
  description = "Internal  and for internet-facing false"
  type        = bool
  default     = false
}

variable "type" {
  description = "The type of load balancer to create: application or network"
  type        = string
  default     = "application"
}

variable "subnets" {
  description = " A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource."
  type        = list(string)
  default     = []
}


variable "application_security_groups" {
  description = "A set of security group IDs to assign to the LB. Only valid for Load Balancers of type application"
  type        = set(string)
  default     = []
}

variable "access_logs" {
  description = "enable / disable access_logs"
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "The S3 bucket name to store the logs in."
  type        = string
  default     = null
}

variable "access_logs_prefix" {
  description = "The S3 bucket prefix. Logs are stored in the root if not configured."
  type        = string
  default     = null
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application"
  type        = number
  default     = 60
}

variable "target_groups" {
  description = "A list of maps"
  type        = any
  default     = []

}

variable "listener" {
  description = "A list of maps"
  type        = any
  default     = []

}

variable "vpc_id" {
  description = "VPC id"
  type        = string
  default     = null

}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}