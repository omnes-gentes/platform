data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

output "aws" {
  value = {
    account_id = data.aws_caller_identity.current.account_id
    region = data.aws_region.current.name
  }
}