# ---------------------------------------------
# Launch Template for Auto Scaling
# ---------------------------------------------
resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.project}-${var.environment}-app-lt"
  image_id      = data.aws_ami.app.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.app_sg.id,
    aws_security_group.opmng_sg.id
  ]
  # user_dataなど必要に応じて追加
}

# ---------------------------------------------
# Auto Scaling Group
# ---------------------------------------------
resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.project}-${var.environment}-app-asg"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  vpc_zone_identifier       = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id]
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project}-${var.environment}-app-asg"
    propagate_at_launch = true
  }
}

# ---------------------------------------------
# Auto Scaling Policy (CPU 50%でスケール)
# ---------------------------------------------
resource "aws_autoscaling_policy" "scale_policy" {
  name                   = "cpu-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
}
# ---------------------------------------------
# key pair
# ---------------------------------------------
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file("./src/stockmg-dev-keypair.pub")

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}

# ---------------------------------------------
# Elastic IP for app_server
# ---------------------------------------------
resource "aws_eip" "app_server_eip" {
  vpc = true
  tags = {
    Name    = "${var.project}-${var.environment}-app-server-eip"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }
}

resource "aws_eip_association" "app_server_eip_assoc" {
  instance_id   = aws_instance.app_server.id
  allocation_id = aws_eip.app_server_eip.id
}

# ---------------------------------------------
# SSM Parameter Store
# ---------------------------------------------
resource "aws_ssm_parameter" "host" {
  name  = "/${var.project}/${var.environment}/app/POSTGRES_HOST"
  type  = "String"
  value = aws_db_instance.postgresql_standalone.address
}

resource "aws_ssm_parameter" "port" {
  name  = "/${var.project}/${var.environment}/app/POSTGRES_PORT"
  type  = "String"
  value = aws_db_instance.postgresql_standalone.port
}

resource "aws_ssm_parameter" "database" {
  name  = "/${var.project}/${var.environment}/app/POSTGRES_DATABASE"
  type  = "String"
  value = aws_db_instance.postgresql_standalone.name
}

resource "aws_ssm_parameter" "username" {
  name  = "/${var.project}/${var.environment}/app/POSTGRES_USERNAME"
  type  = "SecureString"
  value = aws_db_instance.postgresql_standalone.username
}

resource "aws_ssm_parameter" "password" {
  name  = "/${var.project}/${var.environment}/app/POSTGRES_PASSWORD"
  type  = "SecureString"
  value = random_string.db_password.result
}


# ---------------------------------------------
# EC2 Instance
# ---------------------------------------------
resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.app.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_ec2_profile.name
  vpc_security_group_ids = [
    aws_security_group.app_sg.id,
    aws_security_group.opmng_sg.id
  ]
  key_name = aws_key_pair.keypair.key_name
  # user_data                   = file("./src/initialize.sh")

  tags = {
    Name    = "${var.project}-${var.environment}-app-ec2"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }
}
