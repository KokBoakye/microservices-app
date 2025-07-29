variable "ecr_services" {
  default = [
    "frontend",
    "cartservice",
    "checkoutservice",
    "productcatalogservice",
    "recommendationservice",
    "currencyservice",
    "emailservice",
    "paymentservice",
    "shippingservice",
    "adservice"
  ]
}

resource "aws_ecr_repository" "microservices" {
  for_each = toset(var.ecr_services)

  name = each.key

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = each.key
    Environment = "dev"
  }
}
