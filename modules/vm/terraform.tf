terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>4.77.0"
    }
  }
  required_version = "~>1.5.4"
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
  # credentials = file("key.json")
}
