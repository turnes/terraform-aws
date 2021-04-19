
resource "aws_ecs_task_definition" "this" {

  family                   = var.name
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name : var.c_name,
      image : var.c_image,
      cpu : var.cpu,
      memory : var.memory,
      networkMode : "awsvpc",
      portMappings : [
        {
          containerPort : var.c_port
          protocol : "tcp",
          hostPort : var.c_port
        }
      ]
    }
  ])


}


###
# IAM ROLES
###
resource "aws_iam_role" "task_role" {
  name               = "ecs_tasks-role-${var.name}"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
            "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role" "task_execution" {
  name               = "ecsTaskExecutionRole-${var.name}"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
            "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

locals {
  task_policy = file(var.task_role_policy_file_path)
}

resource "aws_iam_role_policy" "task_role_policy" {
  name   = "ecsTaskRolePolicy-${var.name}"
  role   = aws_iam_role.task_role.id
  policy = local.task_policy
}


resource "aws_iam_role_policy" "task_execution_policy" {
  name   = "ecsTaskExecutionPolicy-${var.name}"
  role   = aws_iam_role.task_execution.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}