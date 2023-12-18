data "archive_file" "bundle" {
  type = "zip"
  source_dir  = "${local.api_path}/main/src"
  output_path = "${local.dist_path}/bundle.zip"
  excludes = [
    "__tests__",
    "*.yml"
  ]

}

resource "aws_s3_object" "bundle" {
  bucket     = aws_s3_bucket.this.id
  key        = "lambda/bundle-${data.archive_file.bundle.output_md5}.zip"
  source     = data.archive_file.bundle.output_path
  #  etag       = filemd5(data.archive_file.bundle.output_path)
  kms_key_id = var.kms_id
  tags       = module.config.tags
}