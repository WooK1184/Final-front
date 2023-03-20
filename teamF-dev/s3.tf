resource "aws_s3_bucket" "teamf-FE" {
  bucket = "teamf-FE"
  acl    = "public-read"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Resource = [
          "${aws_s3_bucket.teamf-FE.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Environment = "Production"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.teamf-FE.id
  key    = "index.html"
  source = "path/to/local/index.html"
}

resource "aws_s3_bucket_website" "website" {
  bucket = aws_s3_bucket.teamf-FE.id

  index_document = "index.html"
  error_document = "index.html"
}

output "bucket_id" {
  value = aws_s3_bucket.teamf-FE.id
}

output "website_url" {
  value = aws_s3_bucket_website.website_domain
}


