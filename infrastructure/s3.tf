resource "aws_s3_bucket" "parking_status_app" { // creates s3 bucket 
  bucket = "parking-status-website-20240316"
}


resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.parking_status_app.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.parking_status_app.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



resource "aws_s3_bucket_acl" "s3_acl" { // sets up acl for public access
  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this
  ]

  bucket = aws_s3_bucket.parking_status_app.id
  acl    = "public-read"
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

data "aws_iam_policy_document" "s3_policy_doc" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.parking_status_app.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3_policy" { // setting up permisions to allow public to read objects in bucket 
  bucket = aws_s3_bucket.parking_status_app.id
  policy = data.aws_iam_policy_document.s3_policy_doc.json
}


