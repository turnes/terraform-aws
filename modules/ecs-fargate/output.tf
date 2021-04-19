output "service_name" {
  description = "Name of the service"
  value       = aws_ecs_service.this.name
}

# output "host_port" {
#   description = "Host port"
#   value       = aws_ecs_task_definition.this.hostPort
# }