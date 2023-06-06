output "load_balancer_arn" {
  value  = aws_lb.app_lb.arn
}
output "loadbalancer_id" {
  value = aws_lb.app_lb.id
}