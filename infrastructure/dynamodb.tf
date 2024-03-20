/*
resource "aws_dynamodb_table" "this" {
  name           = "GarageStatus"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "GarageID"
  range_key      = "GarageName"

  attribute {
    name = "GarageID"
    type = "S"
  }
  attribute {
    name = "GarageName"
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

*/
