# ---------------------------------------------
# CloudFront Distribution (ALBオリジン)
# ---------------------------------------------
resource "aws_cloudfront_distribution" "app_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "App distribution via CloudFront"
  default_root_object = "index.html"

  origin {
    domain_name = aws_lb.alb.dns_name
    origin_id   = "alb-origin"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb-origin"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name    = "${var.project}-${var.environment}-cloudfront"
    Project = var.project
    Env     = var.environment
  }
}
