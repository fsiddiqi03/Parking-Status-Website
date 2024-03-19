resource "aws_lambda_function" "update_status" {
  function_name = "updateParkingStatus"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "python3.8"
  filename      = "lambda_function.zip"

  source_code_hash = filebase64sha256("lambda_function.zip")
}

/*
Update Iam role, needs to be a @data not @resource 


*/

resource "aws_iam_role" "lambda_exec" {

  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda_dynamodb_access" {
  name = "lambda_dynamodb_access"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:*:*:table/ParkingStatus"
      },
    ]
  })
}
