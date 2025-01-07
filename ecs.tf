resource "aws_ecs_cluster" "privatebin_cluster" {
  name = "privatebin-cluster"
}

resource "aws_ecs_task_definition" "privatebin_task" {
  family                   = "privatebin-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "privatebin"
      image = "privatebin/nginx-fpm-alpine"
      cpu   = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "privatebin_service" {
  name            = "privatebin-service"
  cluster         = aws_ecs_cluster.privatebin_cluster.id
  task_definition = aws_ecs_task_definition.privatebin_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnets[2].id]
    security_groups = [aws_security_group.nginx_sg.id]
    assign_public_ip = true
  }
}
