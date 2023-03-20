resource "aws_cloudfront_access_identity" "s3_access_identity" {
  comment = "S3 Access Identity"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [
    aws_s3_bucket.teamf-FE,
  ]

  enabled = true

  origin {
    domain_name = aws_s3_bucket.teamf-FE.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.teamf-FE.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_origin_access_identity.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.teamf-FE.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    acm_certificate_arn = "인증서 추가"
    ssl_support_method  = "sni-only"
  }

  aliases = [
    "kimdoliving.com",
  ]

  default_root_object = "index.html"
}

resource "aws_route53_zone" "teamf_domain_zone" {
  name = "kimdoliving.com"
}

resource "aws_route53_record" "cloudfront" {
  zone_id = aws_route53_zone.teamf_domain_zone.zone_id
  name    = "kimdoliving.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}