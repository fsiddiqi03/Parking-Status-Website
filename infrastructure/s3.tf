resource "aws_s3_bucket" "parking_status_app" { // creates s3 bucket 
  bucket = "parking-status-website-20240316"
}


resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.parking_status_app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_acl" "s3_acl" { // sets acl to private, so access can only happen through cloudfront 
  depends_on = [
    aws_s3_bucket_public_access_block.this
  ]

  bucket = aws_s3_bucket.parking_status_app.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "s3_website_config" { //cofigures the bucket for website hosting 
  bucket = aws_s3_bucket.parking_status_app.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

locals {
  cloudfront_oai = aws_cloudfront_origin_access_identity.oai.id
}

data "aws_iam_policy_document" "s3_policy_doc" {
  statement {
    sid    = "CloudFrontAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${local.cloudfront_oai}"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.parking_status_app.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3_policy" { // setting up permisions to allow public to read objects in bucket 
  bucket = aws_s3_bucket.parking_status_app.id
  policy = data.aws_iam_policy_document.s3_policy_doc.json
}


