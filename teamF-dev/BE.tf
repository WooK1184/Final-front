resource "aws_ecs_cluster" "teamf-ecs" {
  name = "teamf-cluster"
}

resource "aws_ecs_task_definition" "teamf-def" {
  family                   = "teamf-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
  [
    {
      "name": "teamf-container",
      "image": "차후 기입",
      "portMappings": [
        {
          "containerPort": 3333,
          "hostPort": 3333,
          "protocol": "tcp"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/teamf",
          "awslogs-region": "ap-northeast-2",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "teamf-svc" {
  name            = "teamf-svc"
  cluster         = aws_ecs_cluster.teamf-ecs.id
  task_definition = aws_ecs_task_definition.teamf-def.arn
  desired_count   = 2

  network_configuration {
    subnets = ["aws_subnet.sv-private1.id", "aws_subnet.sv-private2.id"]

    security_groups = [aws_security_group.ecs-rds.id]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
    container_name   = "teamf-container"
    container_port   = 3333
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}
