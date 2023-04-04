locals {
  cluster_name = length(var.environment) > 0 ? "${var.name_prefix}-${var.environment}-fargate-cluster-${name_suffix}" : "${var.name_prefix}-${var.environment}-fargate-cluster"
}

resource "aws_kms_key" "ecs_execute_command" {
  count = var.include_execute_command_configuration ? 1 : 0

  description             = "${var.name_prefix}-${var.environment}-ecs-execute-command"
  deletion_window_in_days = 15
}

resource "aws_cloudwatch_log_group" "ecs_execute_command" {
  count = var.include_execute_command_configuration ? 1 : 0

  name = local.cluster_name
}

resource "aws_ecs_cluster" "this" {
  name = local.cluster_name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  dynamic "configuration" {
    for_each = var.include_execute_command_configuration ? [1] : []
    content {
      execute_command_configuration {
        kms_key_id = try(aws_kms_key.ecs_execute_command[0].arn, null)
        logging    = "OVERRIDE"

        log_configuration {
          cloud_watch_encryption_enabled = true
          cloud_watch_log_group_name     = try(aws_cloudwatch_log_group.ecs_execute_command[0].name, null)
        }
      }
    }
  }

  network_configuration {
    subnets = length(var.subnets) > 0 ? var.subnets : null
  }

  tags = { Name = "${local.cluster_name}" }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = var.capacity_providers

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}