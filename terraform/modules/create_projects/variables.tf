# TODO allow admin project to be provided or created


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
    description = "The prefix that will be prepended to created project IDs."
}

variable billing_account {
    type = string
    description = "Billing account with which to create projects"
}

# variable environments {
#     type = list(string)
#     description = "A list of environment names to create"
# }

