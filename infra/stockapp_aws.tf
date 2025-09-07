# 株管理システム用 AWS Terraform サンプル
# --------------------------------------
# VPC, EC2, RDS(MySQL), セキュリティグループ, IAMロールを作成します。

provider "aws" {
  region = "ap-northeast-1" # 東京リージョン
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Web/DB用SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Web
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # MySQL
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c3fd0f5d33134a76" # Amazon Linux 2023 (例)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name      = "your-key-name" # 事前に作成したキーペア名

  tags = {
    Name = "stockapp-web"
  }
}

resource "aws_db_instance" "mysql" {
  identifier         = "stockapp-db"
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  username           = "admin"
  password           = "yourpassword" # 本番はSSMや環境変数で管理
  db_name            = "stockdb"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  skip_final_snapshot = true
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.main.name
}

resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.public.id]
}

# 必要に応じてIAMロールやS3バケットも追加可能
