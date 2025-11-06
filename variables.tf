variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "secret_name" {
  description = "AWS Secrets Manager secret name. Auto-generated if left blank."
  type        = string
  default     = ""
}

variable "kms_key_id" {
  description = "Optional KMS key ID for encrypting the secret"
  type        = string
  default     = null
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Full engine version"
  type        = string
  default     = "8.0.36"
}

variable "engine_version_major" {
  description = "Major engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial allocated storage (GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Max auto-storage limit (GB)"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "subnet_ids" {
  description = "Custom subnet IDs (optional)"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Custom security group IDs (optional)"
  type        = list(string)
  default     = []
}

variable "storage_encrypted" {
  description = "Encrypt RDS storage"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Skip snapshot on deletion"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Protect from deletion"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Should DB be public?"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

# ====================================
# Parameter Group
# ====================================

variable "parameter_group_family" {
  description = "DB parameter group family"
  type        = string
  default     = "mysql8.0"
}

variable "parameters" {
  description = "Custom DB parameters"
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
# Option Group
# ====================================

variable "option_group_options" {
  description = "Option group settings"
  type = list(object({
    option_name = string
    option_settings = optional(list(object({
      name  = string
      value = string
    })))
  }))
  default = []
}
