variable environments {
    description = "TODO"
    type = map(object({
        region = string
    }))
}

variable service_name {
    description = "TODO"
    type = string
}

variable folder_id {
    type = string
    description = "If creating projects, this will be used as the folder in which to create them"
}

variable proj_name_prefix {
    type = string
    description = "The prefix that will be prepended to created project names. Do not include a trailing space."
}

variable proj_id_prefix {
    type = string
    description = "The prefix that will be prepended to created project IDs. Do not include a trailing hyphen."
}

variable billing_account {
    type = string
    description = "Billing account with which to create projects"
}

variable admin_project_id {
    type = string
    description = "The project ID of the project hosting build artifacts and WIF config"
}

variable github_owner_name {
    type = string
    description = "TODO"
}

variable github_repository_name {
    type = string
    description = "TODO"
}