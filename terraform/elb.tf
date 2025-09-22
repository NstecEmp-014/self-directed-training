# ---------------------------------------------
# ALB (Application Load Balancer)
# ---------------------------------------------
resource "aws_lb" "alb" {
  name               = "${var.project}-${var.environment}-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id]
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.project}-${var.environment}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
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
    Name    = "${var.project}-${var.environment}-app-tg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# Auto Scaling Groupのターゲットグループ登録
resource "aws_autoscaling_attachment" "asg_to_alb" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  alb_target_group_arn   = aws_lb_target_group.alb_tg.arn
}
