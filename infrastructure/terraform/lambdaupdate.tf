resource "aws_lambda_function" "update_status" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "updateParkingStatus"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = lambda_function.lambda_handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.8"

}
