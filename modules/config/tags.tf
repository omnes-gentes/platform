locals {
  default_tags = {
    Organization = "omnes-gentes"
    Project      = "12G"
    Domain       = "omnesgentesproject.com"
    Environment  = "prd"
    Managed      = "terraform"
  }
}

output "tags" {
  value = local.default_tags
}