output "vpc_id" {
  description = "ID of VPC"
  value       = aws_vpc.this.id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "private_route_tables" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private.*.id

}