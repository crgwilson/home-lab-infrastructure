resource "aws_route53_zone" "route53_public_zone" {
  name    = var.domain_name
  comment = "Main DNS zone for externally facing services"
  tags = {
    "name"      = var.domain_name
    "service"   = "dns"
    "terraform" = "true"
  }
}
