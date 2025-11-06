output "rds_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.this.endpoint
}

output "rds_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "rds_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "parameter_group" {
  description = "Name of the DB parameter group"
  value       = aws_db_parameter_group.this.name
}

output "option_group" {
  description = "Name of the DB option group"
  value       = aws_db_option_group.this.name
}
#cred updated
