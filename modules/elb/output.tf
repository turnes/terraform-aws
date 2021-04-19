output "alb_arn" {
  description = "ID of the load balancer"
  value       = aws_lb.this.id
}

output "target_group_arn" {
  description = "List of target groups"
  value       = aws_alb_target_group.this[0].arn
}

output "alb_dns" {
  description = "dns of the load balancer"
  value       = aws_lb.this.dns_name
}