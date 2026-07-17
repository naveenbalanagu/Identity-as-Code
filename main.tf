# Define Provider Here

terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
  }
}

# Create a okta group resource 

resource "okta_group" "engineering" {
  name        = "Engineering-All"
  description = "Managed Via Terraform - contains all Engineering staff"
}

# create another group resource 

resource "okta_group" "productowners" {
  name        = "Productowners-All"
  description = "Managed Via Terraform - contains all Productowners staff"
}

# create a custom portal

resource "okta_app_oauth" "custom_portal" {
  label          = "Internal App"
  type           = "web"
  grant_types    = ["authorization_code"]
  redirect_uris  = ["https://localhost:8080/login/callback"]
  response_types = ["code"]
}

# Assign group to okta application

resource "okta_app_group_assignment" "eng_portal_access" {
  app_id   = okta_app_oauth.custom_portal.id
  group_id = okta_group.engineering.id
}
