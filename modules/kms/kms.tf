resource "aws_kms_key" "this" {
  description         = "${module.config.project.description} KMS for ${module.config.aws.region}"
  multi_region        = true
  enable_key_rotation = true

  deletion_window_in_days = 30
  policy = data.aws_iam_policy_document.policy.json

  tags = module.config.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${module.config.project.name}-${module.config.aws.region}"
  target_key_id = aws_kms_key.this.key_id
}

output "global" {
  value = {
    id           = aws_kms_key.this.id
    arn          = aws_kms_key.this.arn
    name         = aws_kms_alias.this.name
    deletion     = aws_kms_key.this.deletion_window_in_days
    multi_region = aws_kms_key.this.multi_region
    rotation     = aws_kms_key.this.enable_key_rotation
  }
}