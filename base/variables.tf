resource "random_string" "my_numbers" {
    length           = 16
    special          = true
    override_special = "-"
    upper = false
}