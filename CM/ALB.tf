module "alb" {
  source                        = "terraform-aws-modules/alb/aws"
  load_balancer_name            = "alb-terra-01"
  security_groups               = ["sg-edcd9784", "sg-edcd9785"]
  log_bucket_name               = "logs-us-east-2-123456789012"
  log_location_prefix           = "my-alb-logs"
  subnets                       = ["subnet-abcde012", "subnet-bcde012a"]
  tags                          = "${map("Environment", "test")}"
  vpc_id                        = "vpc1"
  https_listeners               = "${list(map("certificate_arn", "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012", "port", 443))}"
  https_listeners_count         = "1"
  http_tcp_listeners            = "${list(map("port", "80", "protocol", "HTTP"))}"
  http_tcp_listeners_count      = "1"
  target_groups                 = "${list(map("name", "foo", "backend_protocol", "HTTP", "backend_port", "80"))}"
  target_groups_count           = "1"
}