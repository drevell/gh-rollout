output "admin_project_id" {
    value = google_project.admin_project.project_id
    description = "Project ID of the project containing the artifact registry and WIF pool "
}

output "worker_project_ids" {
    value = google_project.worker_project
    description = "A map of the per-environment projects that will Cloud Run / GKE"
}