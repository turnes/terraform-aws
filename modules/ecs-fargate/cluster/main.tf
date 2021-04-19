resource "aws_ecs_cluster" "this" {
  name = var.name

  tags = merge(
    { Name : var.name },
    var.tags
  )
}