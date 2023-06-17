data "aws_route53_zone" "main" {
  name = "asterisk.chat"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.api.asterisk.chat"
  type    = "A"

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}

data "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "api.asterisk.chat"
  type    = "A"

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}