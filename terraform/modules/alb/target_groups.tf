# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "alb_tg" {
  name        = "p-app-alb-tg"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.VPC_ID
}

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
# resource "aws_lb_target_group_attachment" "alb_tg_a" {
#   target_group_arn = aws_lb_target_group.alb_tg.arn
#   target_id        = var.CLUSTER_ID
#   port             = 80
# }