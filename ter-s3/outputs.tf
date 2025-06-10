output "bucket_name" {
  value = yandex_storage_bucket.diploma-tfstate-bucket-300.bucket
}

output "sa_access_key" {
  value = yandex_iam_service_account_static_access_key.ig-sa-key.access_key
  sensitive = true
}

output "sa_secret_key" {
  value = yandex_iam_service_account_static_access_key.ig-sa-key.secret_key
  sensitive = true
}

# Темплейт бэкенда
resource "local_file" "backend_config" {
  filename = "${path.module}/../ter-main/backend.tf"
  content = templatefile("${path.module}/backend.tftpl", {
    bucket_name   = yandex_storage_bucket.diploma-tfstate-bucket-300.bucket
    access_key    = yandex_iam_service_account_static_access_key.ig-sa-key.access_key 
    secret_key    = yandex_iam_service_account_static_access_key.ig-sa-key.secret_key
    state_path    = "terraform.tfstate"  # Путь к файлу состояния
  })

  # перезапись при каждом изменении входных данных
  lifecycle {
    # ignore_changes = [file_permission]  # Игнорируем изменения прав (опционально)
    replace_triggered_by = [
      yandex_storage_bucket.diploma-tfstate-bucket-300.bucket,  # Пересоздаем файл, если изменился бакет
      yandex_iam_service_account_static_access_key.ig-sa-key.access_key,
      yandex_iam_service_account_static_access_key.ig-sa-key.secret_key
    ]
  }
}
