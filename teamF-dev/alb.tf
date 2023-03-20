resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-alb.id]
  subnets = [
    aws_subnet.NAT-pub.id,
    aws_subnet.pub2.id
  ]
  enable_cross_zone_load_balancing = true

  #   enable_deletion_protection = true

  tags = {
    Environment = "web-alb"
  }
}

resource "aws_lb_target_group" "web_lb_tg" {
  name     = "web-lb-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    interval            = 30
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "web-alb_lintener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
  }
}