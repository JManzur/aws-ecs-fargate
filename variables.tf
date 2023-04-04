#######################################
# Required variables:
#######################################

variable "name_prefix" {
  type        = string
  description = "[REQUIRED] Used to name and tag resources."
}

variable "environment" {
  type        = string
  description = "[REQUIRED] Used to name and tag resources."
}

#######################################
# Optional variables:
#######################################

variable "name_suffix" {
  type        = string
  description = "[OPTIONAL] Used to name and tag global resources."
  default     = null
}

variable "enable_container_insights" {
  type        = bool
  description = "[OPTIONAL] Enable container insights for the cluster." # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-container-insights.html
  default     = false
}

variable "include_execute_command_configuration" {
  type        = bool
  description = "[OPTIONAL] Enable execute command configuration for the cluster." # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html
  default     = false
}

variable "capacity_providers" {
  type        = list(string)
  description = "[OPTIONAL] List of capacity providers to use for the cluster."
  default     = ["FARGATE"]

  validation {
    condition     = length(var.capacity_providers) > 0
    error_message = "At least one capacity provider must be specified."
  }
  validation {
    condition     = length([for provider in var.capacity_providers : provider if provider == "FARGATE_SPOT" || provider == "FARGATE"]) == length(var.capacity_providers)
    error_message = "Only FARGATE_SPOT and FARGATE are valid capacity providers."
  }
}

variable "subnets" {
  type        = list(string)
  description = "[OPTIONAL] List of subnets to use for the cluster."
  default     = null
}