data "aws_iam_policy_document" "lambda_exec" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = ["arn:aws:logs:${module.config.aws.region}:${module.config.aws.account_id}:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.logs.arn}:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    resources = [aws_dynamodb_table.user.arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [var.kms_id]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3-object-lambda:WriteGetObjectResponse",
    ]
    resources = ["${aws_s3_bucket.this.arn}/*"]
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "${module.config.project.name}-serverless-lambda-exec"
  description = "${module.config.project.description} Lambda Exection Role"
  tags = module.config.tags

  assume_role_policy = data.aws_iam_policy_document.lambda_exec.json
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${module.config.project.name}-serverless-lambda-policy"
  path        = "/"
  description = "${module.config.project.description} Lambda Exection Policy"

  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

output "iam" {
  value = {
    lambda_exec = {
      name = aws_iam_role.lambda_exec.name
      policy = [
        aws_iam_policy.lambda_policy.name
      ]
    }
  }
}
