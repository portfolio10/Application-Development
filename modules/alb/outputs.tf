output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "alb_https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = aws_lb_listener.https.arn
}

output "alb_http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = aws_lb_listener.http_redirect.arn
}

output "blue_target_group_name" {
  description = "The name of the Blue target group"
  value       = aws_lb_target_group.blue.name
}

output "green_target_group_name" {
  description = "The name of the Green target group"
  value       = aws_lb_target_group.green.name
}

output "blue_target_group_arn" {
  description = "The ARN of the Blue target group"
  value       = aws_lb_target_group.blue.arn
}
