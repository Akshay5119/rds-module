# AWS RDS Terraform Module

This module creates an AWS RDS instance using Terraform.  
It automatically detects your **default VPC**, **subnets**, and **security group**.

It also supports:
- **Parameter Groups** (custom DB parameters)
- **Option Groups** (plugins, extensions)
- **Multi-AZ**, **encryption**, and **backups**

## ✅ Usage Example

```hcl
provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source        = "git::https://github.com/Akshay5119/aws-rds-module.git?ref=main"
  db_identifier = "aks-db"
  username      = "admin"
  password      = "MySecurePass123!"

  parameters = [
    { name = "max_connections", value = "200" },
    { name = "sql_mode", value = "STRICT_TRANS_TABLES" }
  ]

  option_group_options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"
      option_settings = [
        { name = "SERVER_AUDIT_EVENTS", value = "CONNECT,QUERY" },
        { name = "SERVER_AUDIT_FILE_ROTATIONS", value = "10" }
      ]
    }
  ]
}
