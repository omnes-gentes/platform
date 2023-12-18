locals {
  api_path = "${path.module}/../../../../server/.aws-sam/build"
  dist_path = "${path.module}/dist"

  lambda_runtime = "nodejs20.x"
}