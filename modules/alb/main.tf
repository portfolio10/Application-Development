# ALB
# 외부 사용자를 위한 로드 밸런서이므로 외부에 노출해야해서 tfsec 경고 무시
resource "aws_lb" "main" {
    name = var.alb_name
    internal = false
    load_balancer_type = "application"
    security_groups = [var.alb_security_group_id]
    subnets = var.public_subnet_ids

    #인프라와 상이함. 인프라는 true
    enable_deletion_protection = false 

    tabs = {
        Name = val.alb_name
    }
}


# Target Group
resource "aws_lb_target_group" "blue" {
  name        = "${var.alb_name}-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.project_name}-blue-tg"
  }
}

resource "aws_lb_target_group" "green" {
  name        = "${var.alb_name}-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  
  # 우린 없음. target_type = "instance"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.alb_name}-green"
  }
}

# ALB 리스너
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy2016-08"
  certificate_arn   = var.alb_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

resource "aws_lb_listener" "https_redirect" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}