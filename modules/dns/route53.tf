resource "aws_route53_zone" "public" {
  name = module.config.project.domain
  comment = "${module.config.project.description} DNS"
  tags = module.config.tags
}

output "public" {
  value = {
    name         = aws_route53_zone.public.name
    zone_id      = aws_route53_zone.public.zone_id
    name_servers = aws_route53_zone.public.name_servers
  }
}
