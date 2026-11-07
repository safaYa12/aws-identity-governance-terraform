output "account_assignments" {
  description = "Created AWS account assignments"

  value = {
    for key, assignment in aws_ssoadmin_account_assignment.department_access :

    key => {
      assignment_id = assignment.id
      principal_id  = assignment.principal_id
      target_id     = assignment.target_id
    }
  }
}