variable "name" {
  description = "Identifier"
  type        = string
  default     = null
}

variable "task_role_policy_file_path" {
  description = "Json file's path"
  type        = string
  default     = null
}

variable "cpu" {
  description = "CPU size"
  type        = number
  default     = null
}

variable "memory" {
  description = "Memory size"
  type        = number
  default     = null
}

variable "c_name" {
  description = "Identifier"
  type        = string
  default     = null
}

variable "c_image" {
  description = "Image of the container"
  type        = string
  default     = null
}

variable "c_port" {
  description = "Port of the container"
  type        = number
  default     = null
}

variable "host_port" {
  description = "Port of the host"
  type        = string
  default     = null
}

variable "cluster_id" {
  description = "ID of the cluster"
  type        = string
  default     = null
}

variable "desired_count" {
  description = "Number of containers"
  type        = number
  default     = 1
}

variable "security_groups_ids" {
  description = "List of ids of SG"
  type        = list(string)
  default     = []
}

variable "private_subnets_ids" {
  description = "List of ids of subnets"
  type        = list(string)
  default     = null
}

variable "target_groups" {
  description = "List of ids of targetgroups"
  type        = string
  default     = null

}


variable "tags" {
  description = "List of tags"
  type        = map(string)
  default     = {}
}