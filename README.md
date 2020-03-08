# GCP Cloud SQL MySQL Application Database

Create a GCP Cloud SQL MySQL application database with read-only and read-write users.

## Usage

```
module "db" {
  source           = "github.com/infrastructure-as-code/terraform-google-cloud-sql-mysql"
  database_name    = "db1"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  project_id       = "a-project-id"
  tier             = "db-f1-micro"
  readwrite_users = [
    "app1_api",
    "app1_app",
  ]
  readonly = [
    "app1_dev",
  ]
  authorized_networks = [
    {
      name  = "app"
      value = "191.213.206.0/24"
    },
    {
      name  = "humans"
      value = "185.146.218.25/32"
    },
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| authorized\_networks | list of IP CIDRs that are allowed to access the database | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| database\_name | Database name | `string` | n/a | yes |
| database\_version | Database version (MYSQL\_5\_6, MYSQL\_5\_7, POSTGRES\_9\_6, POSTGRES\_11) | `string` | n/a | yes |
| enable\_ha | Enable high availability with regional deployment | `bool` | `false` | no |
| project\_id | Project ID | `string` | n/a | yes |
| readonly\_users | list of users with read-only access | `list(string)` | `[]` | no |
| readwrite\_users | list of users with read-write access | `list(string)` | `[]` | no |
| region | GCP region | `string` | n/a | yes |
| tier | Instance tier | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_ip\_address | Private IP address of database instance |
| public\_ip\_address | Public IP address of database instance |
