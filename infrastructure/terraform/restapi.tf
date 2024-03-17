resource "aws_api_gateway_rest_api" "this" {
  name        = "ParkingStatusAPI"
  description = "API for updating parking status from the garage system"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "ParkingStatusAPI"
      version = "1.0"
    }
    paths = {
      "/updateStatus" = {
        post = {
          summary     = "Updates parking status"
          operationId = "updateParkingStatus"
          x-amazon-apigateway-integration = {
            uri                  = aws_lambda_function.update_status.invoke_arn
            httpMethod           = "POST"
            type                 = "AWS_PROXY"
            payloadFormatVersion = "1.0"
          }
          responses = {
            "200" = {
              description = "Status updated successfully"
            }
          }
        }
      }
    }
  })
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  description = "Initial deployment"

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "prod"
}

