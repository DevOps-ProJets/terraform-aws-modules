variable "allocated_storage" {
  type        = number
  description = "The allocated storage size for the database"
  default     = 20
}

variable "engine_version" {
  type = string
}

variable "engine" {
  type        = string
  description = "The database engine (e.g., MySQL, PostgreSQL)"
  default     = "mysql"
}

variable "instance_class" {
  type        = string
  description = "The RDS instance class"
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
  default =   "MySQL Database"
  description = "The name of the database"
}

variable "username" {
  type        = string
  description = "The master username for the database"
}

variable "password" {
  type        = string
  description = "The master password for the database"
  sensitive   = true
}

variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the DB subnet group"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip taking a final snapshot"
  default     = true
}

variable "final_snapshot_identifier" {
  type        = string
  description = "Identifier for the final snapshot"
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether the DB instance should be publicly accessible"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "Whether to enable multi-AZ deployment"
  default     = false
}

variable "storage_type" {
  type        = string
  description = "The storage type (e.g., gp2, io1)"
  default     = "gp2"
}

variable "backup_retention_period" {
  type        = number
  description = "Number of days to retain backups"
  default     = 7
}
