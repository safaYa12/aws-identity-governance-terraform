locals {
  permission_profiles = {
    engineering = {
      name        = "Engineering-Developer"
      description = "Restricted development and observability access"
    }

    sales = {
      name        = "Sales-ReadOnly"
      description = "Read-only access for Sales"
    }

    finance = {
      name        = "Finance-ReadOnly"
      description = "Read-only access for Finance"
    }

    hr = {
      name        = "HR-ReadOnly"
      description = "Read-only access for HR"
    }

    education = {
      name        = "Education-ReadOnly"
      description = "Read-only access for Education"
    }
  }
}

resource "aws_ssoadmin_permission_set" "department" {
  for_each = local.permission_profiles

  name             = each.value.name
  description      = each.value.description
  instance_arn     = var.instance_arn
  session_duration = var.session_duration
}
locals {
  readonly_departments = toset([
    "sales",
    "finance",
    "hr",
    "education"
  ])
}

resource "aws_ssoadmin_managed_policy_attachment" "readonly" {
  for_each = local.readonly_departments

  instance_arn = var.instance_arn

  permission_set_arn = aws_ssoadmin_permission_set.department[
    each.value
  ].arn

  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_ssoadmin_permission_set_inline_policy" "engineering" {

  instance_arn = var.instance_arn

  permission_set_arn = aws_ssoadmin_permission_set.department[
    "engineering"
  ].arn

  inline_policy = file(
    "${path.module}/../../policies/engineering-policy.json"
  )
}
