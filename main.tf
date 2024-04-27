resource "google_storage_bucket" "gcpgentleman" {
  name = "gcpgentleman-bucket1-terraform"
  storage_class = "nearline"
  location = "us-central1"

  labels = {
    "environment" = "tf_enviroment"
    "department" = "compliance"
  }
  
  uniform_bucket_level_access = true 

  lifecycle_rule {
    condition {
      age = 7
    }
    action {
      type = "SetStorageClass"
      storage_class = "Coldline"
    }
  }

  retention_policy {
    is_locked = true
    retention_period = 864000
  }
}

resource "google_storage_bucket_object" "picture" {
  name = "packers_logo"
  bucket = google_storage_bucket.gcpgentleman.name
  source = "packers.png"
}