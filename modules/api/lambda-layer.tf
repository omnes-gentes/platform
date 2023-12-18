data "archive_file" "layer_libs" {
  type = "zip"
  source_dir  = "${local.api_path}/main/node_modules"
  output_path = "${local.dist_path}/node_modules.zip"
}

resource "aws_s3_object" "layer_libs" {
  bucket     = aws_s3_bucket.this.id
  key        = "lambda/layer-libs-${data.archive_file.layer_libs.output_md5}.zip"
  source     = data.archive_file.layer_libs.output_path
  #  etag       = filemd5(data.archive_file.layer.output_path)
  kms_key_id = var.kms_id
  tags       = module.config.tags
}

resource "aws_lambda_layer_version" "libs" {
  layer_name = "node_modules"

  s3_bucket         = aws_s3_object.layer_libs.bucket
  s3_key            = aws_s3_object.layer_libs.key
  s3_object_version = aws_s3_object.layer_libs.version_id

  compatible_runtimes = [local.lambda_runtime]
}