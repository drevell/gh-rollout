# variable environments {
#     description = "TODO"
#     type = map(object({
#         region = string
#     }))
# }

variable service_name {
    description = "TODO"
    type = string
}

variable folder_id {
    type = string
    description = "If creating projects, this will be used as the folder in which to create them"
}

# variable proj_name_prefix {
#     type = string
#     description = "The prefix that will be prepended to created project names. Do not include a trailing space."
# }

# variable proj_id_prefix {
#     type = string
#     description = "The prefix that will be prepended to created project IDs. Do not include a trailing hyphen."
# }

variable billing_account {
    type = string
    description = "Billing account with which to create projects"
}

variable admin_project_id {
    type = string
    description = "The project ID of the project hosting build artifacts and WIF config"
}

# variable github_owner_name {
#     type = string
#     description = "TODO"
# }

variable github_repository {
    type = string
    description = "TODO"
}

variable initial_container_image {
    type = string
    default = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable cicd_service_account_email {
    type = string
}

variable cloudrun_region {
    type = string
}

variable environment_name {
    type = string
}

variable project_id {
    type  = string
}

variable project_name {
    type = string
}

# variable github_repository {
#     type = string
#     description = "format is $OWNER/$REPOSITORY"
# }

variable protected_branches {
    type = bool
    default = false
}

variable reviewer_users {
    type = list(number)
    default = null
}

variable reviewer_teams {
    type = list(number)
    default = null
}

variable artifact_repository_location {
    type = string
}

variable artifact_repository_id {
    type = string
}
