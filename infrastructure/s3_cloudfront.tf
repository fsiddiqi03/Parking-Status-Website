resource "aws_s3_bucket" "parking_status_app" { // creates s3 bucket 
    bucket = "parking_status_app"
}
 
resource "aws_s3_bucket_acl" "s3_acl" {
    bucket = aws_s3_bucket.parking_status_app.id     // sets up acl for public access 
    acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3_website_config" {  //cofigures the bucket for website hosting 
    bucket = aws_s3_bucket.parking_status_app.bucket
    
    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "index.html"
    }
}

resource "aws_s3_bucket_policy" "s3_policy" {   // setting up permisions to allow public to read objects in bucket 
  bucket = aws_s3_bucket.parking_status_app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id = "BucketPolicy"
    Statement = [

        {
            Sid       = "IPAllow"
            Effect    = "Allow"
            Principal = "*"
            Action    = ["s3:GetObject"]
            Resource  = "${aws_s3_bucket.parking_status_app.arn}/*"
        },
    ]
  })
}

