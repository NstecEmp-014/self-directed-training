# ---------------------------------------------
# Route53
# ---------------------------------------------
resource "aws_route53_zone" "route53_zone" {
  name          = var.domain
  force_destroy = false

  tags = {
    Name    = "${var.project}-${var.environment}-domain"
    Project = var.project
    Env     = var.environment
  }
}

# ---------------------------------------------
# Route53 Record (Aレコード)
# ---------------------------------------------
resource "aws_route53_record" "app_server_a" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "app"
  type    = "A"
  ttl     = 300
  records = [aws_eip.app_server_eip.public_ip]
}


