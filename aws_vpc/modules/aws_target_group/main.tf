
resource "aws_lb_target_group" "tg_alb" {
  name     = var.tg_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400 # 1 day
  }
}