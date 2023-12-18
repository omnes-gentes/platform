resource "aws_dynamodb_table" "user" {
  name         = "users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"
  attribute {
    name = "user_id"
    type = "S"
  }
#  attribute {
#    name = "name"
#    type = "S"
#  }
#  attribute {
#    name = "email"
#    type = "S"
#  }
#  attribute {
#    name = "phone"
#    type = "S"
#  }
#  attribute {
#    name = "address"
#    type = "S"
#  }
#  attribute {
#    name = "country"
#    type = "S"
#  }
#  global_secondary_index {
#    name            = "UserEmailIndex"
#    hash_key        = "category"
#    range_key       = "email"
#    projection_type = "ALL"
#  }
}

output "dynamo" {
  value = {
    user = {
      arn = aws_dynamodb_table.user.arn
      name = aws_dynamodb_table.user.name
    }
  }
}