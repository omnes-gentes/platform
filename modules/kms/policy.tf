data "aws_iam_policy_document" policy {
  statement {
    sid = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${module.config.aws.account_id}:root"]
    }
    actions = ["kms:*"]
    resources = ["*"]
  }
#  statement {
#    effect = "Allow"
#    principals {
#      type        = "service"
#      identifiers = ["s3.${module.config.aws.region}.amazonaws.com"]
#    }
#    actions = [
#      "kms:Encrypt*",
#      "kms:Decrypt*",
#      "kms:ReEncrypt*",
#      "kms:GenerateDataKey*",
#      "kms:Describe*"
#    ]
#    resources = ["*"]
#  }
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${module.config.aws.region}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }
}