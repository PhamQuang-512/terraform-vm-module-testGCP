terraform {
  backend "gcs" {
    bucket = "quangpham5-bucket-01"
    prefix = "terraform/state"
  }
}
