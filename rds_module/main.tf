# IAM Role for RDS Monitoring
# resource "aws_iam_role" "rds_monitoring_role" {
#   name = "rds-monitoring-role"

#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Action" : "sts:AssumeRole",
#         "Effect" : "Allow",
#         "Principal" : {
#           "Service" : "monitoring.rds.amazonaws.com"
#         }
#       }
#     ]
#   })

#   tags = var.tags
# }


# resource "aws_iam_role_policy_attachment" "rds_monitoring_role_policy" {
#   role       = aws_iam_role.rds_monitoring_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
# }



# Create a Custom Parameter Group for RDS
resource "aws_db_parameter_group" "rds_custom_parameter_group" {
  name   = "${var.rds_name}-custom-parameter-group"
  family = var.db_parameter_group_family

  description = "Custom parameter group for ${var.rds_name}"

  dynamic "parameter" {
    for_each = var.rds_parameters
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]

      # Apply the appropriate method depending on the parameter type
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = merge(var.tags, {
    Name = "${var.rds_name}-custom-parameter-group"
  })
}



# Create Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.rds_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.rds_name}-subnet-group"
  })
}

# Create RDS Instance with Secrets Manager Integration
resource "aws_db_instance" "default" {
  identifier                            = var.rds_name
  engine                                = "mysql"
  engine_version                        = var.db_engine_version
  instance_class                        = var.instance_class
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage
  multi_az                              = var.multi_az
  db_subnet_group_name                  = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids                = var.security_group_id
  port                                  = var.db_port
  # performance_insights_enabled          = var.performance_insights
  # performance_insights_retention_period = var.retention_period
  backup_retention_period               = var.backup_retention_period
  publicly_accessible                   = false
  # enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  storage_type                          = var.storage_type
  storage_encrypted                     = true
  parameter_group_name                  = aws_db_parameter_group.rds_custom_parameter_group.name

  username                    = var.db_username
  password                    =  var.password

  # monitoring_interval = var.monitoring_interval

  skip_final_snapshot = true

  tags = merge(var.tags, {
    Name = var.rds_name
  })

  depends_on = [
    aws_db_subnet_group.rds_subnet_group,
    aws_db_parameter_group.rds_custom_parameter_group
  ]
}
