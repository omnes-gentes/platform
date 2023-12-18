resource "aws_s3_bucket" "this" {
  bucket = "${module.config.project.name}-${module.config.aws.account_id}-${module.config.aws.region}"
  tags   = module.config.tags
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_id
      sse_algorithm     = "aws:kms"
    }
  }
}

output "s3" {
  value = {
    name       = aws_s3_bucket.this.id
    acl        = aws_s3_bucket_acl.this.acl
    versioning = aws_s3_bucket_versioning.this.versioning_configuration[0].status
  }
}