resource "random_string" "id" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

output "id" {
  value = random_string.id.result
}
