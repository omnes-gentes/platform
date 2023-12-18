output "project" {
  value = {
    name        = "12g-${local.default_tags.Organization}"
    description = "12G Omnes Gentes"
    domain      = "12g.${local.default_tags.Domain}"
  }
}