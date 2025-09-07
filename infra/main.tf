provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  tags = {
    Name = "self-directed-training-web"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  name                  = "stockdb"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
}