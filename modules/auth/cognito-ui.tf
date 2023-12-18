resource "aws_cognito_user_pool_client" "client" {
  name                         = module.config.project.name
  user_pool_id                 = aws_cognito_user_pool.this.id
  // We can configure additional providers like Facebook, Google, etc
  supported_identity_providers = [
    "COGNITO",
  ]

#  allowed_oauth_scopes = [
#    "email",
#    "openid",
#  ]
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = module.config.project.name
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_user_pool_ui_customization" "this" {
  css        = ".label-customizable {font-weight: 400;}"
#  image_file = filebase64("${path.module}/logo.jpg")

  # Refer to the aws_cognito_user_pool_domain resource's
  # user_pool_id attribute to ensure it is in an 'Active' state
  user_pool_id = aws_cognito_user_pool_domain.this.user_pool_id
}

output "url" {
  value = "https://${aws_cognito_user_pool_domain.this.domain}.auth.${module.config.aws.region}.amazoncognito.com/login"
}