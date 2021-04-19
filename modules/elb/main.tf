resource "aws_lb" "this" {
  name               = var.name
  name_prefix        = var.name_prefix
  internal           = var.internal
  load_balancer_type = var.type

  subnets = var.subnets

  //enable_deletion_protection = true



  // only valid for Application Load Balancer
  security_groups = var.application_security_groups
  idle_timeout    = var.idle_timeout
  // end only valid for Application Load Balancer

  dynamic "access_logs" {
    for_each = var.access_logs ? [1] : []
    content {
      bucket  = aws_s3_bucket.lb_logs.bucket
      prefix  = var.access_logs_prefix ? var.access_logs_prefix : var.name
      enabled = var.access_logs
    }
  }

  tags = var.tags
}

resource "aws_alb_target_group" "this" {
  count = length(var.target_groups)

  name        = lookup(var.target_groups[count.index], "name", null)
  vpc_id      = var.vpc_id
  port        = lookup(var.target_groups[count.index], "port", null)
  protocol    = "TCP"
  target_type = "ip"
}

resource "aws_alb_listener" "this" {
  count             = length(var.listener)
  load_balancer_arn = aws_lb.this.arn
  port              = lookup(var.listener[count.index], "port", null)
  protocol          = lookup(var.listener[count.index], "protocol", null)

  default_action {
    target_group_arn = aws_alb_target_group.this[count.index].arn
    type             = lookup(var.listener[count.index], "type", null)
  }

}