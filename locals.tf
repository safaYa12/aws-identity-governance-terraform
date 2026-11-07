locals {

  # Read employee CSV
  employees_raw = csvdecode(
    file("${path.module}/employees.csv")
  )

  # Normalize employee records
  employees = {

    for employee in local.employees_raw :

    trimspace(employee.employee_id) => {

      employee_id = trimspace(employee.employee_id)

      first_name = trimspace(employee.first_name)

      last_name = trimspace(employee.last_name)

      email = lower(trimspace(employee.email))

      department = lower(trimspace(employee.department))

      role = upper(trimspace(employee.role))

      employment_status = upper(
        trimspace(employee.employment_status)
      )
    }
  }

  active_employees = {
    for employee_id, employee in local.employees :

    employee_id => employee

    if employee.employment_status == "ACTIVE"
  }
  invalid_employee_records = {

    for employee_id, employee in local.employees :

    employee_id => {

      employee_id = employee.employee_id
      email       = employee.email

    }

    if employee.employee_id == "" ||
    employee.first_name == "" ||
    employee.last_name == "" ||
    !can(regex("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", employee.email)) ||
    !contains(var.allowed_departments, employee.department) ||
    !contains(var.allowed_roles, employee.role) ||
    !contains(["ACTIVE", "INACTIVE"], employee.employment_status)

  }
  invalid_employee_ids = keys(
    local.invalid_employee_records
  )
}

  