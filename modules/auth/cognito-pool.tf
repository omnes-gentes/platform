resource "aws_cognito_user_pool" "this" {
  name = module.config.project.name

  email_verification_subject = "Your Verification Code"
  email_verification_message = "Please use the following code: {####}"
  alias_attributes           = ["email"]
  auto_verified_attributes   = ["email"]

  password_policy {
    minimum_length    = 6
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  username_configuration {
    case_sensitive = false
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 7
      max_length = 256
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true

    string_attribute_constraints {
      min_length = 3
      max_length = 256
    }
  }

  tags = module.config.tags
}

output "pool" {
  value = {
    arn  = aws_cognito_user_pool.this.arn
    id   = aws_cognito_user_pool.this.id
    name = aws_cognito_user_pool.this.name
  }
}