resource "aws_lambda_function" "api" {
  function_name = "${module.config.project.name}-serveless-api"
  description   = "${module.config.project.description} Serverless API"

  s3_bucket         = aws_s3_object.bundle.bucket
  s3_key            = aws_s3_object.bundle.key
  s3_object_version = aws_s3_object.bundle.version_id

  source_code_hash = data.archive_file.bundle.output_base64sha256

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler     = "handlers/main.handler"
  runtime     = local.lambda_runtime
  layers      = [aws_lambda_layer_version.libs.arn]
  memory_size = 128
  timeout     = 3

  environment {
    variables = {
      USER_TABLE = aws_dynamodb_table.user.name
    }
  }

  role = aws_iam_role.lambda_exec.arn
  tags = module.config.tags
}

resource "aws_lambda_alias" "api" {
  name             = "latest"
  description      = "${module.config.project.description} Serverless Latest Version"
  function_name    = aws_lambda_function.api.arn
  function_version = aws_lambda_function.api.version
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

output "lambda" {
  value = {
    api = {
      arn     = aws_lambda_function.api.arn
      name    = aws_lambda_function.api.function_name
      runtime = aws_lambda_function.api.runtime
      alias   = aws_lambda_alias.api.function_version
    }
    layer = {
      libs = {
        arn = aws_lambda_layer_version.libs.arn
        name = aws_lambda_layer_version.libs.layer_name
      }
    }
  }
}