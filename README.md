# AWS RDS Terraform Module (Automated Secrets)

This module creates an **AWS RDS instance** securely with:
- 🔐 Automatic **AWS Secrets Manager credential creation**
- 🔄 Dynamic **password generation**
- ☁️ Default **VPC/subnet/SG detection**
- ⚙️ Support for **Parameter Groups** & **Option Groups**

---

## 🧩 Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source        = "git::https://github.com/Akshay5119/aws-rds-module.git?ref=main"
  db_identifier = "aks-db"
  db_username   = "admin"
  secret_name   = "rds/aks-db/credentials"

  parameters = [
    { name = "max_connections", value = "200" },
    { name = "sql_mode", value = "STRICT_TRANS_TABLES" }
  ]
}
