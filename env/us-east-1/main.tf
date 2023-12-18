module "config" {
  source = "../../modules/config"
}
output "config" {
  value = module.config
}

module "kms" {
  source = "../../modules/kms"
}
output "kms" {
  value = module.kms
}

module "dns" {
  source = "../../modules/dns"
}
output "dns" {
  value = module.dns
}

module "auth" {
  source = "../../modules/auth"
}
output "auth" {
  value = module.auth
}

module "api" {
  source = "../../modules/api"
  kms_id = module.kms.global.arn
}
output "api" {
  value = module.api
}