output "permission_sets" {
  description = "Created department permission sets"

  value = {
    for department, permission_set in aws_ssoadmin_permission_set.department :

    department => {
      name = permission_set.name
      arn  = permission_set.arn
    }
  }
}