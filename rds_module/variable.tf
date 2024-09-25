variable "rds_name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "password" {
  type = string
  description = "master passowrd of the rds"
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
}

variable "max_allocated_storage" {
  description = "The maximum allocated storage for the RDS instance"
  type        = number
}

variable "multi_az" {
  description = "Whether to create a Multi-AZ RDS instance"
  type        = bool
}

variable "subnet_ids" {
  description = "List of subnet names where the RDS instance will be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the subnets are located"
  type        = string
}

variable "db_port" {
  description = "The port on which the DB instance will accept connections"
  type        = number
  default     = 3306
}

variable "performance_insights" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

variable "retention_period" {
  description = "The amount of time in days to retain Performance Insights data"
  type        = number
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = []
}

variable "storage_type" {
  description = "The storage type to be associated with the RDS instance"
  type        = string
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between Enhanced Monitoring metrics collection points"
  type        = number
  default     = 60
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "security_group_id" {
  description = "The security group ID to associate with the RDS instance"
  type        = list(string)
}

# Database Parameter Group Family
variable "db_parameter_group_family" {
  description = "The family of the DB parameter group."
  type        = string
}

# RDS Custom Parameters
variable "rds_parameters" {
  description = "A list of custom RDS parameters."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
