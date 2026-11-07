output "provisioned_users" {
  description = "Created Identity Center users"

  value = {
    for employee_id, user in aws_identitystore_user.employees :

    employee_id => {
      user_id  = user.user_id
      username = user.user_name
    }
  }
}