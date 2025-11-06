variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine (mysql, postgres, etc.)"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Engine version (full)"
  type        = string
  default     = "8.0.36"
}

variable "engine_version_major" {
  description = "Major engine version (used by option group)"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Instance type for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial storage (in GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage auto-scaling limit (in GB)"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group. Defaults to default VPC subnets."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of VPC security group IDs. Defaults to default VPC SG."
  type        = list(string)
  default     = []
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Skip snapshot when deleting DB"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Protect RDS instance from accidental deletion"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Should the database be publicly accessible?"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to RDS resources"
  type        = map(string)
  default     = {}
}

# ====================================
# Parameter Group Configuration
# ====================================

variable "parameter_group_family" {
  description = "DB parameter group family (e.g., mysql8.0, postgres15)"
  type        = string
  default     = "mysql8.0"
}

variable "parameters" {
  description = "Custom DB parameters (name/value pairs)"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    { name = "max_connections", value = "150" },
    { name = "slow_query_log", value = "1" }
  ]
}

# ====================================
# Option Group Configuration
# ====================================

variable "option_group_options" {
  description = "List of options for the RDS option group"
  type = list(object({
    option_name = string
    option_settings = optional(list(object({
      name  = string
      value = string
    })))
  }))
  default = []
}
