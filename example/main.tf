provider "google" {
  region = "us-central1"
  zone   = "us-central1-c"
}

################################################################################
data "http" "myip" {
  url = "http://ifconfig.co"
}

################################################################################
module "db" {
  source           = "./.."
  database_name    = "db1"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  project_id       = "service1-32174"
  tier             = "db-f1-micro"
  readwrite_users = [
    "foobar",
  ]
  authorized_networks = [
    {
      name  = "myip"
      value = "${chomp(data.http.myip.body)}/32"
    },
  ]
}

output "db_public_ip_address" {
  value = module.db.public_ip_address
}

output "db_private_ip_address" {
  value = module.db.private_ip_address
}

output "mysql_cmd" {
  value = <<END

mysql -h ${module.db.public_ip_address} -u foobar -p db1

END
}
