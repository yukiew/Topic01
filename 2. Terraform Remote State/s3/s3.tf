resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucketName
  force_destroy = true
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket.bucket]
  bucket     = aws_s3_bucket.bucket.id
  policy     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Sid": "Stmt1704622653819",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::two.totaloggy.live",
                "arn:aws:s3:::two.totaloggy.live/*"
            ]
        }
  ]
}
EOF

}
