# ---------------------------------------------
# RDS parameter group
# ---------------------------------------------
resource "aws_db_parameter_group" "postgresql_standalone_parametergroup" {
  name   = "${var.project}-${var.environment}-postgresql-standalone-parametergroup"
  family = "postgres17"

}

# ---------------------------------------------
# RDS option group
# ---------------------------------------------
resource "aws_db_option_group" "postgresql_standalone_optiongroup" {
  name                 = "${var.project}-${var.environment}-postgresql-standalone-optiongroup"
  engine_name          = "postgres"
  major_engine_version = "17"
}

# ---------------------------------------------
# RDS subnet group
# ---------------------------------------------
resource "aws_db_subnet_group" "postgresql_standalone_subnetgroup" {
  name = "${var.project}-${var.environment}-postgresql-standalone-subnetgroup"
  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-postgresql-standalone-subnetgroup"
    Project = var.project
    Env     = var.environment
  }
}

# ---------------------------------------------
# RDS instance
# ---------------------------------------------
resource "random_string" "db_password" {
  length  = 16
  special = false
}
resource "aws_db_instance" "postgresql_standalone" {
  engine         = "postgres"

  identifier = "${var.project}-${var.environment}-postgresql-standalone"

  username = "postgres"
  password = random_string.db_password.result

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az = false // シングルAZ 後でマルチAZに変更予定
 
  name                   = "stockmanagement"
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.postgresql_standalone_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  parameter_group_name = aws_db_parameter_group.postgresql_standalone_parametergroup.name
  option_group_name    = aws_db_option_group.postgresql_standalone_optiongroup.name
  publicly_accessible  = false
  port                 = 5432

  backup_window              = "03:00-04:00"
  backup_retention_period    = 7
  maintenance_window         = "sun:04:00-sun:04:30"
  auto_minor_version_upgrade = false

  skip_final_snapshot = true
  deletion_protection = false

  apply_immediately = true 

  tags = {
    Name    = "${var.project}-${var.environment}-postgresql-standalone"
    Project = var.project
    Env     = var.environment
  }
}



