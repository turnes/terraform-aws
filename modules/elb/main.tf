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