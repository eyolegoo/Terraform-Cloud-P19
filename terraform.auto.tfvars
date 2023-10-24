region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnet = 2

preferred_number_of_private_subnet = 4

ami-jenkins = "ami-0149b2da6ceec4bb0"

ami-jfrog = "ami-0149b2da6ceec4bb0"

ami-bastion = "ami-0fbcb8cdf41accc75"

ami-nginx = "ami-08168d5ec8bdeaa4f"

ami-sonar = "ami-0965c838c11b28f56"

ami-web = "ami-0a7d7e0b71edfdaa1"

keypair = "DevKey"

account_no = "648544004274"

db-username = "lego"

db-password = "1godwynE"

tags = {
  Enviroment      = "production"
  Owner-Email     = "eyolegoo@gmail.com"
  Managed-By      = "terraform"
  Billing-Account = "648544004274"
}