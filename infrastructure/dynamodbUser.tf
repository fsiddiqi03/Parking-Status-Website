resource "aws_dynamodb_table" "user" {
  name           = "UserInfo"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserID"

  attribute {
    name = "UserID"
    type = "S"
  }


  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }


  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
