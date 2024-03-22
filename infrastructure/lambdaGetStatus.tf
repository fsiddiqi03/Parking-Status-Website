data "archive_file" "lambda" {
  type        = "zip"
  source_file = " "
  output_path = " "
}


resource "aws_lambda_function" "get_status" {
  function_name    = "getParkingStatus"
  handler          = "lambda_get_status.lambda_handler"
  role             = aws_iam_role.lambda_exec.arn
  runtime          = "python3.8"
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
}



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
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

}


data "aws_iam_policy_document" "lambda_dynamodb_access" {
  statement {
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
    ]
    effect    = "Allow"
    resources = ["arn:aws:dynamodb:*:*:table/GarageStatus"]
  }
}

resource "aws_iam_role_policy" "lambda_dynamodb_access" {
  name   = "lambda_dynamodb_access"
  role   = aws_iam_role.lambda_exec.id
  policy = data.aws_iam_policy_document.lambda_dynamodb_access.json
}
