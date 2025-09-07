variable "db_subnet_group_name" {
  description = "DBサブネットグループ名"
  type        = string
}

variable "db_security_group_id" {
  description = "DB用セキュリティグループID"
  type        = string
}
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "db_username" {
  description = "DB username"
  type        = string
}

variable "db_password" {
  description = "DB password"
  type        = string
  sensitive   = true
}