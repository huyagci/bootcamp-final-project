# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
resource "aws_ecs_service" "service" {
  name            = "p-app-service"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task_definition.arn

  deployment_maximum_percent         = 300
  deployment_minimum_healthy_percent = 0
  desired_count                      = 3

  network_configuration {
    security_groups = [var.ECS_SG_ID]
    # Should be deployed to private subnets but requires nat gateway on public subnet and elastic ip
    subnets = [var.PUBLIC_SUBNET_1A, var.PUBLIC_SUBNET_1B, var.PUBLIC_SUBNET_1C]
    # Should be assigned to false when deploying on private subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.TARGET_GROUP_ARN
    container_name   = "nginx-container"
    container_port   = 80
  }

  depends_on = [var.ALB_LISTENER]
}
