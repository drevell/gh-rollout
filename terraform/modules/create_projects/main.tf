

resource "google_project" "worker_project" {
    for_each = toset(var.environments)
    name = "${var.proj_name_prefix} ${each.key}"
    project_id = "${var.proj_id_prefix}-${each.key}"
    folder_id = var.folder_id
    billing_account = var.billing_account
}