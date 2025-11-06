# =============================
# Subnet Group
# =============================
resource "aws_db_subnet_group" "this" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = length(var.subnet_ids) > 0 ? var.subnet_ids : data.aws_subnets.default.ids
  tags       = merge(var.tags, { Name = "${var.db_identifier}-subnet-group" })
}

# =============================
# Parameter Group
# =============================
resource "aws_db_parameter_group" "this" {
  name        = "${var.db_identifier}-param-group"
  family      = var.parameter_group_family
  description = "Custom parameter group for ${var.db_identifier}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = merge(var.tags, { Name = "${var.db_identifier}-param-group" })
}

# =============================
# Option Group
# =============================
resource "aws_db_option_group" "this" {
  name                     = "${var.db_identifier}-option-group"
  engine_name              = var.engine
  major_engine_version     = var.engine_version_major
  option_group_description = "Option group for ${var.db_identifier}"

  dynamic "option" {
    for_each = var.option_group_options
    content {
      option_name = option.value.option_name

      dynamic "option_settings" {
        for_each = lookup(option.value, "option_settings", [])
        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }

  tags = merge(var.tags, { Name = "${var.db_identifier}-option-group" })
}

# =============================
# RDS Instance
# =============================
resource "aws_db_instance" "this" {
  identifier                 = var.db_identifier
  engine                     = var.engine
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  allocated_storage          = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  db_name                    = var.db_name
  username                   = var.username
  password                   = var.password
  db_subnet_group_name       = aws_db_subnet_group.this.name
  parameter_group_name       = aws_db_parameter_group.this.name
  option_group_name          = aws_db_option_group.this.name
  vpc_security_group_ids     = length(var.security_group_ids) > 0 ? var.security_group_ids : [data.aws_security_group.default.id]
  storage_encrypted          = var.storage_encrypted
  multi_az                   = var.multi_az
  backup_retention_period    = var.backup_retention_period
  skip_final_snapshot        = var.skip_final_snapshot
  deletion_protection        = var.deletion_protection
  publicly_accessible        = var.publicly_accessible
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = true

  tags = merge(var.tags, { Name = var.db_identifier })
}
