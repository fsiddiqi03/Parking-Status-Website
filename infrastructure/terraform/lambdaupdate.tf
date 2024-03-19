
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_update_status.py"
  output_path = "lambda_function_payload.zip"
}


resource "aws_lambda_function" "update_status" {
  function_name = "updateParkingStatus"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "python3.8"
  filename      = "lambda_function.zip"

  source_code_hash = data.archive_file.lambda.output_base64sha256
}



/*
Update Iam role, needs to be a @data not @resource 
*/

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "lambda_exec" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role

}

# check if you can have two iam policy docs or if you need one. 

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
