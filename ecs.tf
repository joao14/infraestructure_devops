resource "aws_ecs_cluster" "privatebin_cluster" {
  name = "privatebin-cluster"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
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
      name      = "privatebin"
      image     = "privatebin/nginx-fpm-alpine"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "PRIVATEBIN_MESSAGE"
          value = "ECS PrivateBin is running!"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/privatebin"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "privatebin_service" {
  name            = "privatebin-service"
  cluster         = aws_ecs_cluster.privatebin_cluster.id
  task_definition = aws_ecs_task_definition.privatebin_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.public_subnets[2].id]
    security_groups = [aws_security_group.nginx_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.privatebin_tg.arn
    container_name   = "privatebin"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.privatebin_listener]
}

resource "aws_lb" "privatebin_lb" {
  name               = "privatebin-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_sg.id]
  subnets            = [aws_subnet.public_subnets[2].id]
}

resource "aws_lb_target_group" "privatebin_tg" {
  name        = "privatebin-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "privatebin_listener" {
  load_balancer_arn = aws_lb.privatebin_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.privatebin_tg.arn
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/privatebin"
  retention_in_days = 7
}
