resource "aws_cloudwatch_log_group" "logs" {
  name              = "/aws/lambda/${aws_lambda_function.api.function_name}"
  retention_in_days = 30
  kms_key_id        = var.kms_id

  tags = module.config.tags
}