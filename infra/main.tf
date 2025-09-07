provider "aws" { # AWSプロバイダーの設定開始
  region = var.aws_region # 使用するAWSリージョンを変数から指定
} # AWSプロバイダーの設定終了

resource "aws_instance" "web" { # EC2インスタンス(web)のリソース定義開始
  ami           = var.ami_id # 使用するAMI IDを変数から指定
  instance_type = "t2.micro" # インスタンスタイプを指定
  tags = { # タグの設定開始
    Name = "self-directed-training-web" # インスタンス名タグ
  } # タグの設定終了
} # EC2インスタンス(web)のリソース定義終了

resource "aws_db_instance" "db" { # RDSデータベースインスタンス(db)のリソース定義開始
  allocated_storage    = 20 # データベースのストレージ容量(GB)
  engine               = "mysql" # 使用するDBエンジン
  instance_class       = "db.t3.micro" # DBインスタンスタイプ
  name                 = "stockdb" # DB名
  username             = var.db_username # DBユーザー名(変数から指定)
  password             = var.db_password # DBパスワード(変数から指定)
  parameter_group_name = "default.mysql8.0" # パラメータグループ名
} # RDSデータベースインスタンス(db)のリソース定義終了