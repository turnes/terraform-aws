resource "aws_ecs_service" "this" {
  name            = "${var.name}-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = var.security_groups_ids
    subnets         = var.private_subnets_ids
  }

  load_balancer {
    target_group_arn = var.target_groups
    container_name   = var.c_name
    container_port   = var.c_port
  }


}