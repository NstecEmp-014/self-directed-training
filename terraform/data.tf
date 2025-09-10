data "aws_prefix_list" "s3_pl" {
  name = "com.amazonaws.*.s3"
}

data "aws_ami" "app" { //APサーバ用
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
