output "ecs_cluster_identifiers" {
  description = "Attributes that identify the cluster"
  value = {
    arn  = try(aws_ecs_cluster.this[0].arn, null)
    id   = try(aws_ecs_cluster.this[0].id, null)
    name = try(aws_ecs_cluster.this[0].name, null)
  }
}